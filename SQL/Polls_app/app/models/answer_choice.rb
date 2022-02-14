# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  text        :integer          not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AnswerChoice < ApplicationRecord
    has_many :responses,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: :Response

    belongs_to :question,
        primary_key: :id,
        foreign_key: :question_id,
        class_name: :Question
end
