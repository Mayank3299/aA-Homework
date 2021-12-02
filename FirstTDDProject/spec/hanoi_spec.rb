require 'hanoi'

describe 'Hanoi' do
    subject(:hanoi) {Hanoi.new}
    describe '#won?' do 
        it 'should not be won on the first try' do 
            expect(hanoi).not_to be_won
        end

        it 'is won if all the discs are moved to the second tower' do
            hanoi.move(0,1)
            hanoi.move(0,2)
            hanoi.move(1,2)
            hanoi.move(0,1)
            hanoi.move(2,0)
            hanoi.move(2,1)
            hanoi.move(0,1)
            expect(hanoi).to be_won
        end

        it 'is won if all the towers are moved to the third tower' do 
            hanoi.move(0,2)
            hanoi.move(0,1)
            hanoi.move(2,1)
            hanoi.move(0,2)
            hanoi.move(1,0)
            hanoi.move(1,2)
            hanoi.move(0,2)
            expect(hanoi).to be_won
        end
    end

    describe '#move' do 
        it 'makes sure we can move to a empty stack' do 
            expect(hanoi.move(0,1)).not_to raise_error
        end

        it 'allows moving onto a bigger disc' do
            hanoi.move(0,1)
            hanoi.move(0,2)
            expect(hanoi.move(1,2)).not_to raise_error
        end

        it 'does not allow moving onto a smaller disc' do 
            hanoi.move(0,1)
            expect(hanoi.move(0,1)).to raise_error("Cannot move on smaller disc")
        end

        it 'can not move from an empty stack' do 
            expect(hanoi.move(1,2)).to raise_error("Cannot move from an empty tower")
        end
    end
end