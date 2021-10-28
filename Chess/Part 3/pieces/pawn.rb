require_relative "piece"
class Pawn < Piece
    def symbol
        '♝'.colorize(color)
    end

    def moves
        forward_steps + side_attacks
    end

    private

    def forward_dir
        color == :white ? -1 : 1
    end

    def forward_steps
        i, j= pos
        one_step= [i + forward_dir, j]
        return [] unless board.valid_pos?(one_step) && board.empty?(one_step)
        
        steps= [one_step]
        two_step= [i + 2 * forward_dir, j]
        steps << two_step if board.valid_pos?(two_step) && board.empty?(two_step)
        steps
    end

    def side_attacks
        i, j = pos
        side_attacks_pos=[[i + forward_dir, j - 1], [i + forward_dir, j + 1]]
        side_attacks_pos.select do |new_pos|
            next false unless board.valid_pos?(new_pos)
            next false if board.empty?(new_pos)

            threatned_piece= board[new_pos]
            threatned_piece && threatned_piece.color != color
        end
    end
end
