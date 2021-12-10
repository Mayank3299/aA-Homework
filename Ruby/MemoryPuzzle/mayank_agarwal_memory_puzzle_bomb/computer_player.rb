class ComputerPlayer
   require "byebug" 
    attr_accessor :prev_guessed_pos, :size

    def initialize(size)
        @known_cards= {}
        @matched_cards={}
        @prev_guessed_pos= nil
        @size= size
    end

    def revealed_card(pos, revealed_value)
        @known_cards[pos] = revealed_value
    end

    def receive_match(pos1, pos2)
        @matched_cards[pos1]= true
        @matched_cards[pos2]= true
        puts "Its a match!"
    end

    def prompt
        if @prev_guessed_pos
            second_guess
        else
            first_guess
        end
    end

    def first_guess
        match_first || random_guess
    end

    def second_guess
        match_second || random_guess
    end

    def random_guess
        random_guess= nil
        until random_guess && !@known_cards[random_guess]
            random_guess= [rand(size),rand(size)]
        end
        random_guess
    end

    def match_first
        (pos, _)= @known_cards.find do |pos , val|
            @known_cards.any? do |pos2 , val2|
                (pos != pos2 && val == val2) &&
                !(@matched_cards[pos] || @matched_cards[pos2])
            end
        end
        pos
    end

    def match_second
        (pos, _)= @known_cards.find do |pos , val|
            (pos != @prev_guessed_pos && 
            @known_cards[pos] == @known_cards[@prev_guessed_pos]) &&
            !@matched_cards[pos]
        end
        pos
    end
end