class Card
    
    POSSIBLE_VALUES= [
            :ace, 
            :king, 
            :queen, 
            :jack, 
            :ten, 
            :nine, 
            :eight, 
            :seven,
            :six,
            :five,
            :four,
            :three,
            :two,
        ]
        POSSIBLE_TYPES= [
            :hearts,
            :spades,
            :clubs,
            :diamonds
        ]
    attr_reader :value, :type

    def initialize(value, type)
        raise "Please provide a valid value" unless POSSIBLE_VALUES.include?(value)
        raise "Please provide a valid suit" unless POSSIBLE_TYPES.include?(type)
        @value= value
        @type= type
    end
end