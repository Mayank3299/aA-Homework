require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionLike
    attr_reader :id
    attr_accessor :user_id, :question_id

    def self.all
        datum= QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        datum.map{|data| QuestionLike.new(data)}
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
                question_likes
            WHERE
                id = ?;
        SQL
        return nil unless data.length > 0
        QuestionLike.new(data.first)
    end

    def self.likers_for_question_id(question_id)
        datum= QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                question_likes
            INNER JOIN
                users ON users.id = question_likes.user_id
            WHERE
                question_id = ?
        SQL

        return nil unless datum.length > 0
        datum.map{|data| User.new(data)}  
    end

    def self.num_likes_for_question_id(question_id)
        datum= QuestionsDatabase.instance.get_first_value(<<-SQL, question_id)
            SELECT
                COUNT(*) AS Likes
            FROM
                question_likes
            WHERE
                question_id = ?;
        SQL
        datum[0]
    end

    def self.liked_questions_for_user_id(user_id)
        datum= QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                questions.*
            FROM
                question_likes
            INNER JOIN
                questions ON questions.id = question_likes.question_id
            WHERE
                user_id = ?;
        SQL

        return nil unless datum.length > 0
        datum.map{|data| Question.new(data)} 
    end

    def self.most_liked_questions(n)
        datum= QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                questions.*
            FROM
                question_likes
            INNER JOIN
                questions ON questions.id = question_likes.question_id
            GROUP BY
                questions.id
            ORDER BY
                COUNT(*) DESC
            LIMIT
                ?;
        SQL

        return nil unless datum.length > 0
        datum.map{|data| Question.new(data)}
    end
end