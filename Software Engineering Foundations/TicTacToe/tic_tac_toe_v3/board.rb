class Board
    def initialize(size)
        @grid= Array.new(size){Array.new(size , '_')}
    end

    def [](posiiton)
        row,col= posiiton
        @grid[row][col]
    end

    def []=(posiiton, val)
        row,col= posiiton
        @grid[row][col]= val
    end

    def valid?(posiiton)
        posiiton.all? {|i| 0 <= i && i < @grid.length}
    end

    def empty?(posiiton)
        self[posiiton] == '_'
    end

    def place_mark?(position, mark)
        if self.valid?(position) && self.empty?(position)
            self[position]= mark
        else
            raise " Position is either not empty or not valid!"
        end
    end

    def print
        @grid.each do |sub_grid|
            puts sub_grid.join("  ")
            puts ""
        end
        return
    end

    def win_row?(mark)
       @grid.any? {|row| row.all?(mark)}
    end

    def win_col?(mark)
        @grid.transpose.any? {|col| col.all?(mark)}
    end

    def win_diagonal?(mark)
        left_to_right= (0...@grid.length).all? do |i|
            @grid[i][i] == mark
        end
        
        right_to_left= (0...@grid.length).all? do |i|
            row = i
            col= @grid.length-i-1
            @grid[row][col] == mark
        end

        left_to_right || right_to_left
    end

    def win?(mark)
        return win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        indices= (0...@grid.length).to_a
        posiitons= indices.product(indices) 
        posiitons.any? {|pos| self.empty?(pos)}
    end

    def legal_positions
        indices= (0...@grid.length).to_a
        posiitons= indices.product(indices) 
        posiitons.select {|pos| self.empty?(pos)}
    end
end
