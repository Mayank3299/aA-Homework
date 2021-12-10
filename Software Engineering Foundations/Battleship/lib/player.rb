class Player
    def get_move
        puts "enter a position"
        inp= gets.chomp
        row= inp[0].to_i
        col= inp[-1].to_i
        [row, col]
    end

end
