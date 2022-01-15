require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'

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
end