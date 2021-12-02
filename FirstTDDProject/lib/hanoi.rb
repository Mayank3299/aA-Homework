class Hanoi
    def initialize
        @towers= [[3,2,1],[],[]]
    end

    def move(from, to)
        raise ("Cannot move from an empty tower") if @towers[from].empty?
        raise ("Cannot move on smaller disc") unless valid_move?(from, to)

        @towers[to] << @towers[first].pop
    end

    def valid_move?(from, to)
        return false unless [fro, to].all? {|i| i.between?(0,2)} 

        !@towers[from].empty? && (
            @towers[to].empty? ||
            @towers[from][-1] < @towers[to][-1]
        )
    end

    def won?
        @towers[0].empty? && @towers[1..2].any?(&:empty?)
    end

    def play
        until won?
            puts 'Enter the tower to move from? -'
            from= gets.chomp

            puts 'Enter the tower to move to? -'
            to= gets.chomp

            move(from, to) if valid_move?(from, to)
        end

        puts "You won!"
    end
end