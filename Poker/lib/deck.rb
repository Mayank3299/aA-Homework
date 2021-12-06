require_relative 'card'
require_relative 'hand'

class Deck
    
    def self.all_cards
        deck= []
        Card::POSSIBLE_TYPES.each do |type|
            Card::POSSIBLE_VALUES.each do |value|
                deck << Card.new(value, type)
            end
        end
        deck
    end

    def initialize(cards= Deck.all_cards)
        @cards= cards
    end

    def count
        @cards.count
    end

    def take(number)
        raise "Not enough cards" if number > count
        @cards.shift(number)
    end

    def return(cards)
        @cards += cards
    end

    def shuffle
        @cards.shuffle!
    end

    def deal_hand
        Hand.new(take(5))
    end
end