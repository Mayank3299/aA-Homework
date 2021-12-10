class HumanPlayer

    attr_accessor :prev_guessed_pos
    def initialize(size)
        @prev_guessed_pos= nil
    end

    def prompt
        puts "Please enter a location separated by space to flip the card- "
        inp= gets.chomp.split.map!(&:to_i)
    end

    def revealed_card(pos, val)
        #duck typing
    end

    def receive_match(pos1, pos2)
        puts "Its a match!"
    end

end