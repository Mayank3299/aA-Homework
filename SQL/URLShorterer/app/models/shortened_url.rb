# == Schema Information
#
# Table name: shortened_urls
#
#  id             :bigint           not null, primary key
#  short_url      :string
#  long_url       :string           not null
#  submit_user_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :submit_user_id, :long_url, presence: true
    validates :short_url, uniqueness: true
    validate :no_spamming, :nonpremium_max

    def self.random_code
        loop do
            random_code= SecureRandom::urlsafe_base64(16)
            return random_code unless ShortenedUrl.exists?(short_url: random_code)
        end
    end

    def self.create_for_user_and_long_url!(user, long_url)
        ShortenedUrl.create!({
            long_url: long_url,
            submit_user_id: user.id,
            short_url: ShortenedUrl.random_code
        })
    end

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :submit_user_id,
        class_name: :User

    has_many :visitors,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Visit

    has_many :taggings,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Tagging    
    
    has_many :tag_topics,
        through: :taggings,
        source: :tag_topic
    def num_clicks
        visitors.count
    end

    def num_uniques
        visitors.select(:user_id).distinct.count
    end

    def num_recent_uniques
        visitors
            .select('user_id')
            .where('created_at > ?', 10.minutes.ago)
            .distinct
            .count
    end

    def no_spamming
        last_minute= ShortenedUrl
            .where('created_at >= ?', 1.minute.ago)
            .where(submit_user_id: submit_user_id)
            .length

        errors[:maximum] << 'of 5 urls per minute' if last_minute >= 5
    end

    def nonpremium_max
        return if User.find(self.submit_user_id).premium

        no_of_urls= ShortenedUrl
            .where(submit_user_id: submit_user_id)
            .length

        errors[:Only] << 'premium users can create more than 5 urls' if no_of_urls >= 5
    end

    def self.prune(n)
        ShortenedUrl
            .joins(:submitter)
            .joins('LEFT OUTER JOIN visits ON visits.shortened_url_id = shortened_urls.id')
            .where("(shortened_urls.id IN (
                SELECT
                    shortened_urls.id
                FROM
                    shortened_urls
                INNER JOIN
                    visits ON visits.shortened_url_id = shortened_urls.id
                GROUP BY
                    shortened_urls.id
                HAVING
                    MAX(visits.created_at) < \'#{n.minute.ago}\'
            ) OR (
                visits.id IS NULL AND shortened_urls.created_at < \'#{n.minute.ago}\'
            )) AND users.premium = \'f\'")
            .destroy_all
    end
end
