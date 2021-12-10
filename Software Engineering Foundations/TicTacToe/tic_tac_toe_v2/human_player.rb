class HumanPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark= mark_value
    end

    def get_position
        puts "Player #{mark.to_s} ki turn position dene ki AUR spce ke saath!"
        inp= gets.chomp
        pos= inp.split(" ")
        pos.map! {|ele| ele.to_i}
        raise "Ek kaam sahi se karlo yaar" if pos.length!=2
        pos 
    end
end