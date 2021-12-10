require 'card'

describe 'Card' do 
    describe '#initialize' do
        subject(:card) {Card.new(:ten, :hearts)}

        it 'sets the card correctly' do
            expect(card.type).to eq(:hearts)
            expect(card.value).to eq(:ten)
        end

        it 'raises an error with invalid value' do 
            expect {Card.new(:test, :hearts).to raise_error("Please provide a valid value")}
        end

        it 'raises an error with invalid suit' do 
            expect {Card.new(:five, :test).to raise_error("Please provide a valid type")}
        end
    end
end