class Nqueen

    attr_reader :counter

    def initialize(size)
        @size= size
        @board= make_board(@size)
        @counter= 0
    end
    
    def make_board(size)
        board= Array.new(size) {Array.new(size,"-")}
    end

    def calculate_nqueen(count, row)
        if count == @size
            print_solution
            @counter+=1
            return
        end

        (0...@size).each do |col|
            if placeable(row, col) == true
                @board[row][col] = "Q"
                count += 1
                row +=1
                calculate_nqueen(count, row)
                count-=1
                row-=1
                @board[row][col]= "-"
            end
        end
    end

    def check_row(row,col)
        (0..row).each do |row1|
            return false if @board[row1][col] == "Q"
        end
        true
    end

    def check_diagonal(row, col)
        left_d= row - col
        right_d= row + col
        @board.each_with_index do |sub_arr,i|
            sub_arr.each_with_index do |ele,j|
                if i-j == left_d || i+j == right_d
                    return false if @board[i][j] == "Q"
                end
            end
        end
        true
    end

    def placeable(row,col)
        check_row(row,col) && check_diagonal(row,col)
    end

    def print_solution
        puts "\n\n"
        @board.each do |sub_arr|
            puts sub_arr.join(" ")
        end
    end

    def run
        calculate_nqueen(0,0)
    end
end

if $PROGRAM_NAME == __FILE__
    puts "Enter the size for the board other than 2 and 3- "
    inp= gets.chomp.to_i
    n= Nqueen.new(inp)
    n.run
    puts "\nTotal Solutions- #{n.counter}"
end