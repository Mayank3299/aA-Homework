require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

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

    def self.find_by_author_id(author_id)
        datum= QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                replies
            WHERE
                author_id = ?;
        SQL

        return nil unless datum.length > 0
        datum.map{|data| Reply.new(data)}
    end

    def self.find_by_question_id(question_id)
        datum= QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = ?;
        SQL

        return nil unless datum.length > 0
        datum.map{|data| Reply.new(data)}
    end

    def self.find_by_parent_id(parent_reply_id)
        datum= QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent_reply_id = ?;
        SQL

        return nil unless datum.length > 0
        datum.map{|data| Reply.new(data)}
    end

    def author
        User.find_by_id(author_id)
    end

    def question
        Question.find_by_id(question_id)
    end

    def parent_reply
        Reply.find_by_id(parent_reply_id)
    end

    def child_replies
        Reply.find_by_parent_id(id)
    end

    def save
        if id
            QuestionsDatabase.instance.execute(<<-SQL, author_id, question_id, body, parent_reply_id, id)
                UPDATE
                    replies
                SET
                    author_id = ?,
                    question_id = ?,
                    body = ?,
                    parent_reply_id = ?
                WHERE
                    id = ?;
            SQL
        else
            QuestionsDatabase.instance.execute(<<-SQL, author_id, question_id, body, parent_reply_id)
                INSERT INTO
                    replies(author_id, question_id, body, parent_reply_id)
                VALUES
                    (?,?,?,?);
            SQL

            @id= QuestionsDatabase.instance.last_insert_row_id
        end
    end
end