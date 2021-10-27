require_relative 'stepable'
require_relative "piece"
class King < Piece
    include Stepable
    
    def symbol
        '♚'.colorize(color)
    end

    def move_dirs
        [[-1,-1],
        [-1,0],
        [-1,1],
        [0,-1],
        [0,1],
        [1,-1],
        [1,0],
        [1,1]]
    end
end