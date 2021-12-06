class Card
    include Comparable
    POSSIBLE_VALUES= 
    {
        :ace => 'A', 
        :king => 'K', 
        :queen => 'Q', 
        :jack => 'J', 
        :ten => 10, 
        :nine => 9, 
        :eight => 8, 
        :seven => 7,
        :six => 6,
        :five => 5,
        :four => 4,
        :three => 3,
        :two => 2
    }

    POSSIBLE_TYPES= 
    {
        :hearts => '♥',
        :spades => '♠',
        :clubs => '♣',
        :diamonds => '♦' 
    }

    attr_reader :value, :type

    def initialize(value, type)
        raise "Please provide a valid value" unless POSSIBLE_VALUES.include?(value)
        raise "Please provide a valid suit" unless POSSIBLE_TYPES.include?(type)
        @value= value
        @type= type
    end

    def self.values
        POSSIBLE_VALUES.keys
    end

    def self.types
        POSSIBLE_TYPES.keys
    end

    def ==(other_obj)
        (self.type == other_obj.type) && (self.value == other_obj.value)
    end
   
    def <=> (obj)
        if self == obj
            0
        elsif value != obj.value
            Card.values.index(value) <=> Card.values.index(obj.value)
        elsif type != obj.type
            Card.types.index(type) <=> Card.types.index(obj.type)
        end
    end
end