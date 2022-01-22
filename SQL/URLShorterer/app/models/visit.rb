# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  shortened_url_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Visit < ApplicationRecord
    
    def self.record_visit!(user, shortened_url)
        Visit.create!(
            user_id: user.id,
            shortened_url_id: shortened_url.id
        )
    end

    belongs_to :shortened_url

    belongs_to :visitor,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
end
