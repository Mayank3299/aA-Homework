class Card
    include Comparable
    POSSIBLE_VALUES= 
    {
        :two   => "2",
        :three => "3",
        :four  => "4",
        :five  => "5",
        :six   => "6",
        :seven => "7",
        :eight => "8",
        :nine  => "9",
        :ten   => "10",
        :jack  => "J",
        :queen => "Q",
        :king  => "K",
        :ace   => "A"
    }

    POSSIBLE_TYPES= 
    {
        :clubs => '♣',
        :diamonds => '♦',
        :hearts => '♥',
        :spades => '♠'
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
    
    def self.royal_values
        POSSIBLE_VALUES.keys[-5..-1]
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

    def to_s
        POSSIBLE_VALUES[value] + POSSIBLE_TYPES[type]
    end
end