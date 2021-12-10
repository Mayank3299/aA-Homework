class HumanPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark= mark_value
    end

    def get_position(positions)
        pos= nil
        until positions.include?(pos)
            puts "Player #{mark.to_s} ki turn position dene ki AUR spce ke saath!"
            inp= gets.chomp
            pos= inp.split(" ")
            pos.map! {|ele| ele.to_i}
            puts "#{pos} is not a legal position" if !positions.include?(pos)
            raise "Ek kaam sahi se karlo yaar" if pos.length!=2
        end
        pos
    end
end