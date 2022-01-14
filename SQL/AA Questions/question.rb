require_relative 'questions_database.rb'
class Question
    attr_reader :id
    attr_accessor :title, :body, :author_id

    def self.all
        datum= QuestionsDatabase.instance.execute("SELECT * FROM questions")
        datum.map{|data| Question.new(data)}
    end

    def initialize(options)
        @id= options['id']
        @title= options['title']
        @body= options['body']
        @author_id= options['author_id']
    end

    def self.find_by_id(id)
        data= QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?;
        SQL

        return nil unless data.length > 0
        Question.new(data.first)
    end
end