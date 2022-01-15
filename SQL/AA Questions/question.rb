require_relative 'questions_database'
require_relative 'reply'
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

    def self.find_by_author_id(author_id)
        datum= QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                author_id = ?
        SQL

        return nil unless datum.length > 0
        datum.map{|data| Question.new(data)}
    end

    def replies
        Reply.find_by_question_id(@id)
    end
end