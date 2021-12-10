class ComputerPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark= mark_value
    end

    def get_position(posiitons)
        pos= posiitons.sample
        puts "Computer with mark #{mark.to_s} chose position #{pos.join(" ")}"
        pos
    end
end