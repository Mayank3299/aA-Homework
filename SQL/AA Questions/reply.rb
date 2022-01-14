require_relative 'questions_database'

class Reply
    attr_reader :id
    attr_accessor :author_id, :question_id, :body, :parent_reply_id

    def self.all
        datum= QuestionsDatabase.instance.execute("SELECT * FROM replies")
        datum.map{|data| Reply.new(data)}
    end

    def initialize(options)
        @id = options['id']
        @author_id= options['author_id']
        @question_id= options['question_id']
        @body= options['body']
        @parent_reply_id= options['parent_reply_id']
    end

    def self.find_by_id(id)
        data= QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?;
        SQL

        return nil unless data.length > 0
        Reply.new(data.first)
    end
end