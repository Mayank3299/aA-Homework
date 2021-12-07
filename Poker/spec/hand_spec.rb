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
            
        end
    end
end