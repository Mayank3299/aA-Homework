require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow
    attr_reader :id
    attr_accessor :user_id, :question_id

    def self.all
        datum= QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        datum.map{|data| QuestionFollow.new(data)}
    end

    def initialize(options)
        @id= options['id']
        @user_id= options['user_id']
        @question_id= options['question_id']
    end

    def self.find_by_id(id)
        data= QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?;
        SQL

        return nil unless data.length > 0
        QuestionFollow.new(data.first)
    end

    def self.followers_for_question_id(question_id)
        datum= QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                question_follows
            INNER JOIN
                users ON users.id = question_follows.user_id
            WHERE
                question_id = ?;
        SQL

        return nil unless datum.length > 0
        datum.map{|data| User.new(data)}
    end

    def self.followed_questions_for_user_id(user_id)
        datum= QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                question_follows
            INNER JOIN
                questions ON questions.id = question_follows.question_id
            WHERE
                question_follows.user_id = ?;
        SQL

        return nil unless datum.length > 0
        datum.map{|data| Question.new(data)}
    end
end