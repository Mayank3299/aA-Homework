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
end