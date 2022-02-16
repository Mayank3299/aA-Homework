# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    
    has_many :authored_polls,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :Poll

    has_many :responses,
        primary_key: :id,
        foreign_key: :respondent_id,
        class_name: :Response

    def completed_polls_SQL
        Poll.find_by_sql(<<-SQL)
            SELECT
                polls.*
            FROM
                polls
            INNER JOIN
                questions ON polls.id = questions.poll_id
            INNER JOIN
                answer_choices ON questions.id = answer_choices.question_id
            LEFT OUTER JOIN (
                SELECT
                    *
                FROM
                    responses
                WHERE
                    responses.respondent_id = #{self.id}
            ) AS responses ON answer_choices.id = responses.answer_choice_id
            GROUP BY
                polls.id
            HAVING
                COUNT(DISTINCT questions.id) = COUNT(responses.*)
        SQL
    end

    def completed_polls
        polls_with_completed_counts
            .having("COUNT(DISTINCT questions.id) = COUNT(responses.*)")
    end

    def incomplete_polls
        polls_with_completed_counts
            .having("COUNT(DISTINCT questions.id) > COUNT(responses.*)")
            .having("COUNT(responses.*) > 0")
    end

    def polls_with_completed_counts
        query= <<-SQL
            LEFT OUTER JOIN(
                SELECT
                    *
                FROM
                    responses
                WHERE
                    responses.respondent_id = #{self.id}
            ) AS responses ON answer_choices.id = responses.answer_choice_id
        SQL

        Poll
            .joins(questions: :answer_choices)
            .joins(query)
            .group("polls.id")
    end
end
