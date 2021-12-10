require_relative "piece"

class Board
    attr_reader :grid
    def initialize
        @grid= Array.new(8){Array.new(8)}
    end

    def [](pos)
        row,col= pos
        @grid[row][col]
    end

    def []=(pos,piece)
        row,col= pos
        @grid[row][col]= piece
    end

    def move_piece(start_pos, end_pos)
        if self[start_pos].nil?
            raise "Starting position is not valid"
        end
        piece= self[start_pos]
        self[end_pos]= piece
        self[start_pos]= nil
    end

    def valid_pos?(pos)
        pos.all?{|coord| coord.between?(0,7)}
    end

    def empty?(pos)
        self[pos].empty?
    end
end