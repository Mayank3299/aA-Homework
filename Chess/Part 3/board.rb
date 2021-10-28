require_relative "pieces"
class Board
    attr_reader :grid
    def initialize(fill_board= true)
        @sentinel= NullPiece.instance
        make_board(fill_board)
    end

    def [](pos)
        row,col= pos
        @grid[row][col]
    end

    def []=(pos,piece)
        row,col= pos
        @grid[row][col]= piece
    end

    def move_piece(turn_color, start_pos, end_pos)
        if self[start_pos].empty?
            raise "No piece at starting position"
        end

        piece= self[start_pos]
        if piece.color != turn_color
            raise "Please move piece of your own color"
        elsif !piece.moves.include?(end_pos)
            raise "Please choose a valid ending position"
        elsif !piece.valid_moves.include?(end_pos)
            raise "You can't move into check"
        end

        move_piece!(start_pos, end_pos)
    end

    def move_piece!(start_pos, end_pos)
        piece= self[start_pos]
        self[end_pos]= piece
        self[start_pos]= @sentinel
        piece.pos = end_pos

        nil
    end

    def valid_pos?(pos)
        pos.all?{|coord| coord.between?(0,7)}
    end

    def empty?(pos)
        self[pos].empty?
    end

    def in_check?(color)
        king_pos= find_king(color).pos
        pieces.any?{|p| p.color != color && p.moves.include?(king_pos)}
    end

    def checkmate?(color)
        return false unless in_check?(color)

        pieces.select{|p| p.color == color}.all? do |piece|
            piece.valid_moves.empty?
        end
    end

    def find_king(color)
        king_pos= pieces.find{|p| p.color == color && p.is_a?(King)}
        king_pos || (raise "King not found")
    end

    def pieces
        @grid.flatten.reject(&:empty?)
    end

    def dup
        new_board= Board.new(false)

        pieces.each do |p|
            p.class.new(new_board, p.color, p.pos)
        end
        
        new_board
    end

    def add_piece(piece, pos)
        raise "Position not empty" unless empty?(pos)

        self[pos] = piece
    end

    private

    def make_board(fill_board= false)
        @grid= Array.new(8){Array.new(8, @sentinel)}
        return unless fill_board
        %i(white black).each do |color|
            fill_back_row(color)
            fill_pawn(color)
        end
    end

    def fill_back_row(color)
        back_pieces = [
            Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
        ]
        color == :white ? back_pieces : back_pieces.reverse!
        i = (color == :white ? 7 : 0)

        back_pieces.each_with_index do |piece_class, j|
            piece_class.new(self, color, [i, j])
        end
    end

    def fill_pawn(color)
        i = (color == :white ? 6 : 1)
        8.times{|j| Pawn.new(self, color, [i, j])}
    end

end