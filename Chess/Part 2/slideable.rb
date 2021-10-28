module Slideable
    HORIZONTAL_AND_VERTICAL_DIR= [   
        [-1,0],
        [1,0],
        [0,-1],
        [0,1]
    ].freeze

    DIAGONAL_DIR= [
        [-1,-1],
        [-1,1],
        [1,-1],
        [1,1]
    ].freeze
    
    def h_and_v
        HORIZONTAL_AND_VERTICAL_DIR
    end

    def diag
        DIAGONAL_DIR
    end

    def moves
        moves=[]
         move_dirs.each do |dx,dy|
            moves.concat(grow_potential_moves(dx,dy))
         end

         moves
    end

    def grow_potential_moves(dx,dy)
        moves=[]
        cur_x, cur_y = pos
        loop do
            cur_x, cur_y= cur_x + dx, cur_y + dy
            pos = [cur_x, cur_y]
            break unless board.valid_pos?(pos)

            if board.empty?(pos)
                moves << pos 
            else
                moves << pos if board[pos].color != color

                break
            end
        end
        moves
    end
end