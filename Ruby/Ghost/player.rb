class Player
    attr_reader :name
    def initialize(name)
        @name= name
    end

    def guess(fragment)
        puts "The current fragment is: #{fragment}"
        puts "Please enter a alphabet in consideration:"
        inp= gets.chomp.downcase 
    end

    def alert_invalid_guess(letter)
        puts "\n#{letter} is not a valid letter"
        puts "Your guess must be a letter of the alphabet"
        puts "Your letter must form a word with the fragment.\n"
    end
end