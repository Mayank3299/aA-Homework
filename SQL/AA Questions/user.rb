require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'

class User
    attr_reader :id
    attr_accessor :fname, :lname

    def self.all
        datum= QuestionsDatabase.instance.execute("SELECT * FROM users")
        datum.map{|data| User.new(data)}
    end

    def initialize(options)
        @id= options['id']
        @fname= options['fname']
        @lname= options['lname']
    end 

    def self.find_by_id(id)
        data= QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?;
        SQL

        return nil unless data.length > 0
        User.new(data.first)
    end

    def self.find_by_name(fname, lname)
        datum= QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname= ?
                AND lname= ?;
        SQL

        return nil unless datum.length > 0
        datum.map{|data| User.new(data)}
    end

    def authored_questions
        Question.find_by_author_id(@id)
    end

    def authored_replies
        Reply.find_by_author_id(@id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(id)
    end

    def average_karma
        QuestionsDatabase.instance.get_first_value(<<-SQL, id)
            SELECT
                CAST(COUNT(question_likes.id) AS FLOAT)/
                COUNT(DISTINCT(questions.id)) AS Avg_karma
            FROM
                questions
            LEFT OUTER JOIN
                question_likes ON questions.id = question_likes.question_id
            WHERE
                questions.author_id = ?;
        SQL
    end

    def save
        if id
            QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
                UPDATE
                    users
                SET
                    fname= ?,
                    lname= ?
                WHERE
                    id= ?;
            SQL
        else
            QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            INSERT INTO
                users(fname, lname)
            VALUES
                (?,?)
            SQL

            @id= QuestionsDatabase.instance.last_insert_row_id
        end
    end 
end