require "colorize"
class Piece
    attr_reader :pos, :board, :color

    def initialize(board, color, pos)
        @board= board
        @color= color
        @pos= pos
    end

    def valid_moves
        moves
    end 

    def empty?
        false
    end 

    def to_s
        " #{symbol} "
    end 
end