# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Poll < ApplicationRecord
    validates :title, presence: true

    has_many :questions,
        primary_key: :id,
        foreign_key: :poll_id,
        class_name: :Question
    
    belongs_to :author,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User
    
    has_many :responses,
        through: :questions,
        source: :responses

end
