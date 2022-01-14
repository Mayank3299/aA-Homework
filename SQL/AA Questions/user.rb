require_relative 'questions_database'

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
end