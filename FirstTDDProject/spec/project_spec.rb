require 'project'

describe 'my_uniq' do
    let(:array) {[1,3,4,1,6,7]}
    let(:uniqued_array) {my_uniq(array.dup)}

    it 'removes duplicates' do 
        array.each do |ele|
            expect(uniqued_array.count(ele)).to eq(1)
        end
    end

    it 'only contains elements from the original array' do
        uniqued_array.each do |ele|
            expect(array).to include(ele)
        end
    end

    it 'returns a new array and doesnt make changes in the original array' do 
        expect {
            my_uniq(array)
        }.to_not change(array)
    end
end

describe 'two_sums' do 
    let(:array) {[5,3,1,-3,-1]}
    let(:one_zero) {[1,2,4,0]}
    let(:two_zero) {[0,8,6,1,0]}

    it 'provides all possible combinations' do
        expect(two_sums(array)).to eq([[1,3],[2,4]])
    end

    it 'check for one zeroes' do 
        expect(two_sums(one_zero)).to eq([])
    end

    it 'check for two zeroes' do 
        expect(two_sums(two_zero)).to eq([0,4])
    end
end

describe 'transpose' do 
    let(:array) {[[1,2,3],[4,5,6],[7,8,9]]}

    it 'gives us the transpose' do 
        expect(transpose(array)).to eq([[1,4,7],[2,5,8],[3,6,9]])
    end
end

describe 'pick_stocks' do
    let(:array) {[12,25,10,5,36]}
    let(:single_array) {[1]}
    let(:crash_stocks) {[5,4,3,2,1]}

    it 'provides the best date' do 
        expect(pick_stocks(array)).to eq([3,4])
    end

    it 'doesnt but crash socks' do 
        expect(pick_stocks(crash_stocks)).to be_nil
    end
end