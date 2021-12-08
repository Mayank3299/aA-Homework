class Player

    attr_reader :bankroll, :hand
    def self.buy_in(bankroll)
        Player.new(bankroll)
    end

    def initialize(bankroll)
        @bankroll= bankroll
        @current_bet= 0
    end

    def deal_in(hand)
        @hand= hand
    end

    def take_bet(bet_amount)
        amount= bet_amount - @current_bet
        raise 'bet amount should be less than bankroll' unless amount <= @bankroll
        @current_bet= bet_amount
        @bankroll -= amount
        amount
    end

    def recieve_winnings(amount)
        @bankroll += amount
    end

    def deal_in(hand)
        @hand= hand
    end

    def return_cards
        cards= hand.cards
        @hand= nil
        cards
    end

    def fold
        @folded= true
    end

    def unfold
        @folded= false
    end

    def folded?
        @folded
    end
end