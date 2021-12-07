module TieBreaker
    def pairs
        pairs= []
        @cards.map(&:value).uniq.each do |value|
            if card_value_count(value) == 2
                pairs << @cards.select {|card| card.value == value}
            end
        end
        pairs
    end 

    def tie_breaker(other_obj)
        case rank
        when :royal_flush, :straight_flush, :straight, :flush, :high_card
            high_card <=> other_obj.high_card
        when :four_of_a_kind
            compare_set_then_high_card(4, other_obj)
        when :three_of_a_kind
            compare_set_then_high_card(3, other_obj)
        when :two_pair
            compare_two_pair(other_obj)
        when :one_pair
            compare_set_then_high_card(2, other_obj)
        when :full_house
            compare_full_house(other_obj)
        end
    end

    def compare_set_then_high_card(n, other_obj)
        set_card, other_set_card= set_card(n), other_obj.set_card(n)
        if set_card == other_set_card
            cards_without(set_card.value).last <=> other_obj.cards_without(set_card.value).last
        else
            set_card <=> other_set_card
        end
    end

    def compare_two_pair(other_obj)
        high= high_pair <=> other_obj.high_pair

        if high == 0
            low= low_pair <=> other_obj.low_pair

            if low == 0
                high_card= cards.find {|card| card_value_count(card.value) != 2}
                other_high_card= other_obj.cards.find {|card| card_value_count(card.value) != 2}

                high_card <=> other_high_card
            else
                low
            end
        else
            high
        end
    end

    def high_pair
        if pairs[1][0] < pairs[0][0]
            pairs[0]
        else
            pairs[1]
        end
    end

    def low_pair
        if pairs[0][0] < pairs[1][0]
            pairs[0]
        else
            pairs[1]
        end
    end

    def compare_full_house(other_obj)
        three = set_card(3) <=> other_obj.set_card(3)
        if three == 0
            two = set_card(2) <=> other_obj.set_card(2)
        else
            three
        end
    end
end