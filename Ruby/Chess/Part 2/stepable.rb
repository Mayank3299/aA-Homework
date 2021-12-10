module Stepable
    def moves
        move_dirs.each_with_object do |(dx,dy), moves|
            cur_x, cur_y= pos
            cur_x,cur_y= cur_x + dx, cur_y + dy
            pos= [cur_x, cur_y]
            next unless board.valid_pos?(pos)

            if board.empty?(pos)
                moves << pos
            elsif board[pos].color!=color
                moves << pos
            end
        end
    end 
end
