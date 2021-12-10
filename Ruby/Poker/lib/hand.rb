require_relative 'card'
require_relative 'poker_hands'
class Hand
    include PokerHands

    attr_reader :cards
    def initialize(cards)
        raise 'Please provide 5 cards' if cards.count != 5
        @cards= cards.sort
    end

    def trade_cards(old_cards, new_cards)
        raise 'must have 5 cards' unless old_cards.count == new_cards.count
        raise 'cannot discard unowned card' unless owned?(old_cards)
        take_cards(new_cards) && discard_cards(old_cards) && sort!
    end
    private
    def take_cards(cards)
        @cards += cards
    end

    def discard_cards(old_cards)
        old_cards.each {|card| cards.delete(card)}
    end

    def sort!
        @cards.sort!
    end

    def owned?(old_cards)
        old_cards.all? {|card| @cards.include?(card)}
    end

    def to_s
        @cards.join(' ')
    end

    def self.winner(hands)
        hands.sort.last
    end
end