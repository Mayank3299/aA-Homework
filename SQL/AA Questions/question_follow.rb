require_relative 'questions_database'

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
end