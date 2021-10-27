require_relative "piece"
require_relative "nullpiece"
class Board
    attr_reader :grid
    def initialize
        @sentinel= NullPiece.instance
        @grid= Array.new(8){Array.new(8, @sentinel)}
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

    #def render
    #    @grid.each_with_index do |row, i|
    #        row.each_with_index do |piece, j|
    #            @grid[i][j]= Queen.new(self, :black, [i,j])
    #        end
    #    end
    #    
    #    @grid.each do |rows|
    #        rows.each do |piece|
    #            print piece.to_s.colorize(:background => :light_yellow)
    #        end
    #        puts ""
    #    end
    #    nil
    #end
end