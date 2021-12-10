require "colorize"
class Card
    
    VALUES= ('A'..'Z').to_a

    def self.shuffle_cards(num_of_pairs)
        values= VALUES

        values= values.shuffle.take(num_of_pairs) * 2
        values.shuffle!
        values.map {|val| self.new(val)}
    end

    def self.create_bombs(num_of_bombs)
        bombs= num_of_bombs.map {|val| self.new(val, true)}
    end

    attr_reader :face_value
    attr_accessor :face_up
    def initialize(val, face_up= false)
        @face_value= val
        @face_up= face_up
    end

    def revealed?
        @face_up
    end

    def reveal
        @face_up= true
    end

    def hide
        @face_up= false
    end

    def to_s
        revealed? ? face_value.to_s.blue : " "
    end

    def ==(object)
        object.is_a?(self.class) && object.face_value == self.face_value
    end
end