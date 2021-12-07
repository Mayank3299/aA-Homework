require 'hand'
require 'card'

describe 'Hand' do
    let(:cards) {[
         Card.new(:ten, :spades),
         Card.new(:five, :hearts),
         Card.new(:ace, :hearts),
         Card.new(:two, :diamonds),
         Card.new(:two, :hearts)
    ]}

    subject(:hand) {Hand.new(cards)}
    
    describe '#initialize' do
        it 'initializes a hand of the cards provided' do 
            expect(hand.cards).to match_array(cards)
        end

        it 'raises an error if not five cards' do 
            expect {Hand.new(cards[0..3])}.to raise_error('Please provide 5 cards')
        end
    end

    describe '#trade_cards' do
        let!(:take_cards) {hand.cards[0..1]}
        let!(:new_cards) {[ Card.new(:five, :spades), Card.new(:three, :clubs)]}

        it 'discards specified cards' do
            hand.trade_cards(take_cards, new_cards)
            expect(hand.cards).to_not include(*take_cards)
        end

        it 'takes specified cards' do
            hand.trade_cards(take_cards, new_cards)
            expect(hand.cards).to include(*new_cards)
        end

        it 'raise an error if trade does not result in 5 cards' do
            expect do
                hand.trade_cards(take_cards[0..0], new_cards)
            end.to raise_error('must have 5 cards')
        end

        it 'raise an error if trade tries to discard an unowned card' do
            expect do
                hand.trade_cards([Card.new(:ten, :hearts)], new_cards[0..0])
            end.to raise_error('cannot discard unowned card')
        end
    end
     
    describe 'poker_hands' do
        let(:royal_flush) do
            Hand.new([
                Card.new(:ace, :spades),
                Card.new(:king, :spades),
                Card.new(:queen, :spades),
                Card.new(:jack, :spades),
                Card.new(:ten, :spades)
            ])
        end

        let(:straight_flush) do
            Hand.new([
                Card.new(:eight, :spades),
                Card.new(:seven, :spades),
                Card.new(:six, :spades),
                Card.new(:five, :spades),
                Card.new(:four, :spades)
            ])
        end

        let(:four_of_a_kind) do
            Hand.new([
                Card.new(:ace, :spades),
                Card.new(:ace, :hearts),
                Card.new(:ace, :diamonds),
                Card.new(:ace, :clubs),
                Card.new(:ten, :spades)
            ])
        end

        let(:full_house) do
            Hand.new([
                Card.new(:ace, :spades),
                Card.new(:ace, :clubs),
                Card.new(:king, :spades),
                Card.new(:king, :hearts),
                Card.new(:king, :diamonds)
            ])
        end

        let(:flush) do
            Hand.new([
                Card.new(:four, :spades),
                Card.new(:seven, :spades),
                Card.new(:ace, :spades),
                Card.new(:two, :spades),
                Card.new(:eight, :spades)
            ])
        end

        let(:straight) do
            Hand.new([
                Card.new(:king, :hearts),
                Card.new(:queen, :hearts),
                Card.new(:jack, :diamonds),
                Card.new(:ten, :clubs),
                Card.new(:nine, :spades)
            ])
        end

        let(:three_of_a_kind) do
            Hand.new([
                Card.new(:three, :spades),
                Card.new(:three, :diamonds),
                Card.new(:three, :hearts),
                Card.new(:jack, :spades),
                Card.new(:ten, :spades)
            ])
        end

        let(:two_pair) do
            Hand.new([
                Card.new(:king, :hearts),
                Card.new(:king, :diamonds),
                Card.new(:queen, :spades),
                Card.new(:queen, :clubs),
                Card.new(:ten, :spades)
            ])
        end

        let(:one_pair) do
            Hand.new([
                Card.new(:ace, :spades),
                Card.new(:ace, :hearts),
                Card.new(:six, :diamonds),
                Card.new(:nine, :spades),
                Card.new(:ten, :spades)
            ])
        end

        let(:high_card) do
            Hand.new([
                Card.new(:two, :spades),
                Card.new(:four, :hearts),
                Card.new(:six, :diamonds),
                Card.new(:nine, :spades),
                Card.new(:ten, :spades)
            ])
        end

        let(:hand_ranks) do
            [
                :royal_flush,
                :straight_flush,
                :four_of_a_kind,
                :full_house,
                :flush,
                :straight,
                :three_of_a_kind,
                :two_pair,
                :one_pair,
                :high_card
            ]
        end

        let!(:hands) do
            [
                royal_flush,
                straight_flush,
                four_of_a_kind,
                full_house,
                flush,
                straight,
                three_of_a_kind,
                two_pair,
                one_pair,
                high_card
            ]
        end

        describe '#rank' do
            it 'should correctly identify the hand ranks' do
                hands.each_with_index do |hand, index|
                    expect(hand.rank).to eq(hand_ranks[index])
                end
            end

            context 'when straight' do
                let(:ace_straight) do
                    Hand.new([
                        Card.new(:ace, :spades),
                        Card.new(:two, :hearts),
                        Card.new(:three, :spades),
                        Card.new(:four, :spades),
                        Card.new(:five, :spades)
                    ])
                end

                it 'should allow ace as a low card' do
                    expect(ace_straight.rank).to eq(:straight)
                end
            end
        end

        describe '#<=>' do
            it 'return 1 for a hand with higher rank' do
                expect( royal_flush <=> straight_flush).to eq(1)
            end

            it 'return -1 for a hand with lower rank' do
                expect( straight_flush <=> royal_flush).to eq(-1)
            end

            it 'return 0 for identical hands' do
                expect(straight_flush <=> straight_flush).to eq(0)
            end

            context 'when hands have same rank(tie breaker)' do
                context 'when royal flush' do
                    let(:hearts_royal_flush) do
                        Hand.new([
                            Card.new(:ace, :hearts),
                            Card.new(:king, :hearts),
                            Card.new(:queen, :hearts),
                            Card.new(:jack, :hearts),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    let(:spades_royal_flush) do
                        Hand.new([
                            Card.new(:ace, :spades),
                            Card.new(:king, :spades),
                            Card.new(:queen, :spades),
                            Card.new(:jack, :spades),
                            Card.new(:ten, :spades)
                        ])
                    end

                    it 'compares based on suit' do
                        expect(hearts_royal_flush <=> spades_royal_flush).to eq(-1)
                        expect(spades_royal_flush <=> hearts_royal_flush).to eq(1)
                    end
                end

                context 'when straight flush' do
                    let(:straight_flush_nine) do
                        Hand.new([
                            Card.new(:nine, :spades),
                            Card.new(:eight, :spades),
                            Card.new(:seven, :spades),
                            Card.new(:six, :spades),
                            Card.new(:five, :spades)
                        ])
                    end

                    let(:straight_flush_eight) do
                        Hand.new([
                            Card.new(:eight, :spades),
                            Card.new(:seven, :spades),
                            Card.new(:six, :spades),
                            Card.new(:five, :spades),
                            Card.new(:four, :spades)
                        ])
                    end

                    let(:hearts_flush_nine) do
                        Hand.new([
                            Card.new(:nine, :hearts),
                            Card.new(:eight, :hearts),
                            Card.new(:seven, :hearts),
                            Card.new(:six, :hearts),
                            Card.new(:five, :hearts)
                        ])
                    end

                    it 'compares based on high cards' do
                        expect(straight_flush_nine <=> straight_flush_eight).to eq(1)
                        expect(straight_flush_eight <=> straight_flush_nine).to eq(-1)
                    end

                    it 'compares based on suit when the high card is same' do
                        expect(straight_flush_nine <=> hearts_flush_nine).to eq(1)
                        expect(hearts_flush_nine <=> straight_flush_nine).to eq(-1)
                    end 
                end

                context 'when four_of_a_kind' do
                    let(:ace_four) do
                        Hand.new([
                            Card.new(:ace, :spades),
                            Card.new(:ace, :hearts),
                            Card.new(:ace, :diamonds),
                            Card.new(:ace, :clubs),
                            Card.new(:ten, :spades)
                        ])
                    end

                    let(:king_four) do
                        Hand.new([
                            Card.new(:king, :spades),
                            Card.new(:king, :clubs),
                            Card.new(:king, :diamonds),
                            Card.new(:king, :hearts),
                            Card.new(:ten, :spades)
                        ])
                    end

                    it 'compares based on a four of a kind value' do
                        expect(ace_four <=> king_four).to eq(1)
                        expect(king_four <=> ace_four).to eq(-1)
                    end

                    let(:ace_with_two) do
                        Hand.new([
                            Card.new(:ace, :spades),
                            Card.new(:ace, :hearts),
                            Card.new(:ace, :diamonds),
                            Card.new(:ace, :clubs),
                            Card.new(:three, :spades)
                        ])
                    end

                    it 'compares based on high card value if same four of a kind value' do
                        expect(ace_with_two <=> ace_four).to eq(-1)
                        expect(ace_four <=> ace_with_two).to eq(1)
                    end
                end

                context 'when two pair' do
                    let(:two_pair_3_4) do
                        Hand.new([
                            Card.new(:three, :spades),
                            Card.new(:three, :hearts),
                            Card.new(:four, :hearts),
                            Card.new(:four, :diamonds),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    let(:two_pair_4_5) do
                        Hand.new([
                            Card.new(:five, :spades),
                            Card.new(:five, :hearts),
                            Card.new(:four, :hearts),
                            Card.new(:four, :diamonds),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    let(:pair_of_sixes) do
                        Hand.new([
                            Card.new(:six, :spades),
                            Card.new(:six, :hearts),
                            Card.new(:four, :hearts),
                            Card.new(:five, :diamonds),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    it 'two pair beats one pair' do
                        expect(two_pair_3_4 <=> pair_of_sixes).to eq(1)
                    end

                    it 'higher of the two pair wins' do
                        expect(two_pair_3_4 <=> two_pair_4_5).to eq(-1)
                    end
                end

                context 'when one pair' do
                    let(:ace_pair) do
                        Hand.new([
                            Card.new(:ace, :spades),
                            Card.new(:ace, :spades),
                            Card.new(:queen, :hearts),
                            Card.new(:jack, :diamonds),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    let(:king_pair) do
                        Hand.new([
                            Card.new(:king, :spades),
                            Card.new(:king, :spades),
                            Card.new(:queen, :hearts),
                            Card.new(:jack, :diamonds),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    let(:three_pair_jack_high) do
                        Hand.new([
                            Card.new(:three, :spades),
                            Card.new(:three, :hearts),
                            Card.new(:nine, :diamonds),
                            Card.new(:jack, :hearts),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    let(:three_pair_king_high) do
                        Hand.new([
                            Card.new(:three, :spades),
                            Card.new(:three, :hearts),
                            Card.new(:nine, :diamonds),
                            Card.new(:king, :hearts),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    let(:four_pair) do
                        Hand.new([
                            Card.new(:four, :spades),
                            Card.new(:four, :hearts),
                            Card.new(:ace, :diamonds),
                            Card.new(:two, :hearts),
                            Card.new(:three, :hearts)
                        ])
                    end

                    it 'should compare based on pair value' do
                        expect(ace_pair <=> king_pair).to eq(1)
                        expect(four_pair <=> three_pair_jack_high). to eq(1)
                    end

                    let(:ace_pair_king_high) do
                        Hand.new([
                            Card.new(:ace, :spades),
                            Card.new(:ace, :spades),
                            Card.new(:king, :hearts),
                            Card.new(:jack, :diamonds),
                            Card.new(:ten, :hearts)
                        ])
                    end

                    it 'should compare based on high if same pair value' do
                        expect( ace_pair_king_high <=> ace_pair).to eq(1)
                        expect( three_pair_king_high <=> three_pair_jack_high).to eq(1)
                    end
                end

                context 'when high card' do
                    let(:ten_high) do
                        Hand.new([
                            Card.new(:two, :spades),
                            Card.new(:four, :hearts),
                            Card.new(:six, :diamonds),
                            Card.new(:nine, :spades),
                            Card.new(:ten, :spades)
                        ])
                    end

                    let(:king_high) do
                        Hand.new([
                            Card.new(:two, :spades),
                            Card.new(:four, :hearts),
                            Card.new(:six, :diamonds),
                            Card.new(:nine, :spades),
                            Card.new(:king, :spades)
                        ])
                    end

                    it 'should compare based on high card' do
                        expect(king_high <=> ten_high).to eq(1)
                        expect(ten_high <=> king_high).to eq(-1)
                    end
                end
            end
        end

        describe '.winner' do
            it 'returns the winning hand' do
                high_hands= [flush, straight_flush, one_pair]
                expect(Hand.winner(high_hands)).to eq(straight_flush)

                low_hands = [one_pair, two_pair, three_of_a_kind]
            expect(Hand.winner(low_hands)).to eq(three_of_a_kind)
            end 
        end
    end
end