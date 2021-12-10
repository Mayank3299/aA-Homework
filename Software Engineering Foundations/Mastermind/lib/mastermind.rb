require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code= Code.random(length)
    end

    def print_matches(guess_code)
        puts "Number of exact matches: #{@secret_code.num_exact_matches(guess_code)}"
        puts "Number of near matches: #{@secret_code.num_near_matches(guess_code)}"
    end

    def ask_user_for_guess
        puts "Enter a code"
        code= gets.chomp
        user_code= Code.from_string(code)
        self.print_matches(user_code)

        @secret_code==user_code
    end
end
