require_relative 'questions_database'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'

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

    def followers
        QuestionFollow.followers_for_question_id(id)
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def likers
        QuestionLike.likers_for_question_id(id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(id)
    end

    def self.most_liked(n)
        QuestionLike.most_liked_questions(n)
    end

    def save
        if id
            QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id, id)
                UPDATE
                    questions
                SET
                    title= ?,
                    body= ?
                    author_id= ?
                WHERE
                    id = ?;
            SQL
        else
            QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id)
                INSERT INTO
                    questions(title, body, author_id)
                VALUES
                    (?,?,?);
            SQL

            @id= QuestionsDatabase.instance.last_insert_row_id
        end
    end
end