require "colorize"
class Piece
    attr_reader :pos, :board, :color

    def initialize(board, color, pos)
        raise "Invalid pos" unless board.valid_pos?(pos)
        raise "Invalid color" unless %i(white black).include?(color)
        @board= board
        @color= color
        @pos= pos

        @board.add_piece(self, pos)
    end

    def valid_moves
        moves.reject{|end_pos| move_into_check?(end_pos)}
    end 

    def empty?
        false
    end 

    def to_s
        " #{symbol} "
    end 

    def move_into_check?(end_pos)
        test= board.dup
        test.move_piece!(pos, end_pos)
        test.in_check?(color)
    end
end