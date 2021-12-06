require 'deck'

describe 'Deck' do 
    describe '.all_cards' do 
        subject(:all_cards) {Deck.all_cards}
        it 'has all 52 cards' do 
            expect(all_cards.count).to eq(52)
        end

        it 'has all unique cards' do 
            expect(all_cards.map {|card| [card.value, card.type]}.uniq.count).to eq(all_cards.count)
        end
    end

    let(:cards) do
        [double("card", :value => :five, :type => :hearts),
         double("card", :value => :seven, :type => :diamonds),
         double("card", :value => :nine, :type => :spades)
    ]
    end

    describe '#initialize' do
        it 'initializes deck by default' do
            deck= Deck.new
            expect(deck.count).to eq(52)
        end

        it 'initializes deck with our choice of number cards' do 
            deck= Deck.new(cards)
            expect(deck.count).to eq(3)
        end
    end

    let(:deck) {Deck.new(cards.dup)}

    it 'should not show cards' do
        expect(deck).not_to respond_to(:cards)
    end

    describe '#take' do
        it 'should take number of cards provided from the top of the deck' do 
            expect(deck.take(1)).to eq(cards[0..0])
            expect(deck.take(2)).to eq(cards[1..2])
        end

        it 'removes the card from the deck' do 
            deck.take(2)
            expect(deck.count).to eq(1)
        end

        it 'raises error if not enough cards' do 
            expect do 
                deck.take(4)
            end.to raise_error("Not enough cards")
        end
    end

    let(:more_cards) do
        [
            double("card", :value => :two, :type => :spades),
            double("card", :value => :three, :type => :clubs),
            double("card", :value => :king, :type => :spades)
        ]
    end
    describe '#return' do
        it 'adds the cards at the bottom of the deck' do 
            deck.return(more_cards)
            expect(deck.count).to eq(6)
        end

        it 'adds cards to the bottom of the deck' do 
            deck.return(more_cards)
            deck.take(3)
            
            expect(deck.take(1)).to eq(more_cards[0..0])
            expect(deck.take(1)).to eq(more_cards[1..1])
            expect(deck.take(1)).to eq(more_cards[2..2])
        end
    end

    describe '#shuffle' do
        it 'should check if all the cards are shuffled' do
            cards= deck.take(3)
            deck.return(cards)

            not_shuffled= (1..5).all? do
                deck.shuffle
                shuffled_cards= deck.take(3)
                deck.return(shuffled_cards)

                (0..2).all? {|i| shuffled_cards[i] == cards[i]}
            end

            expect(not_shuffled).to be(false)
        end
    end

    describe '#deal_hand' do
        let(:deck) {Deck.new}
        
        it 'should return a new hand' do
            hand= deck.deal_hand
            expect(hand).to be_a(Hand)
            expect(hand.cards.count).to eq(5)
        end

        it 'should remove cards from the deck' do 
            expect do
                deck.deal_hand
            end.to change{deck.count}.by(-5)
        end
    end
end