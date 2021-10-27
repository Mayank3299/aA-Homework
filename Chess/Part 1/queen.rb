require_relative "piece"
require_relative 'slideable'
class Queen < Piece
    include Slideable

    def move_dirs
        h_and_v + diag
    end

    def symbol
        '♛'.colorize(color)
    end
end