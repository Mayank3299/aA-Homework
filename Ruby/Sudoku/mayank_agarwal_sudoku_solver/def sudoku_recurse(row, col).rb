def sudoku_recurse(row, col)
        debugger
        if @board.solved?
            return true
        end

        (1...10).each do |val|
            @board.render
            if !tile(row,col%9).given?
                if placeable(row,col%9,val)
                    @board[[row,col%9]]= val
                    @board.render
                    col+=1
                    row= col/9
                    if sudoku_recurse(row,col) == true
                        return true
                    end
                    col-=1
                    row= col/9
                    @board[[row,col%9]]= 0
                    @board.render
                end
            else
                return sudoku_recurse(row,col)
            end
        end
    end



    def sudoku_recurse(row, col)
        
        if @board.solved?
            return true
        end

        if col == 9
            row+=1
            col=0
        end

        if tile(row,col).given?
            return sudoku_recurse(row,col+1)
        end

        (1...10).each do |val|
            @board.render
            if placeable(row,col%9,val)
                @board[[row,col]]= val
                @board.render
                if sudoku_recurse(row,col+1) == true
                    return true
                end
                @board[[row,col]]= 0
                @board.render
            end
        end
    end