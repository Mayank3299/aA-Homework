class ShortenedUrl < ApplicationRecord
    validates :submit_user_id, :long_url, presence: true
    validates :short_url, uniqueness: true

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
end