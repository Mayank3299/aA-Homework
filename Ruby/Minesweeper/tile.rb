FLAG= "\u{1F6A9}".force_encoding('utf-8')
BLOC= "\u{25A1}".force_encoding('utf-8')
COLOR= { 1 => :blue, 2 => :magenta, 3 => :light_cyan , 4 => :light_blue, 5 => :white}
require "colorize"
class Tile

    DISHA= [
        [-1,-1],
        [-1,0],
        [-1,1],
        [0,-1],
        [0,1],
        [1,-1],
        [1,0],
        [1,1]
    ]

    def initialize(board, pos)
        @board= board 
        @pos= pos   
        @bombed, @flagged, @explored= false, false, false
    end

    def flagged?
        @flagged
    end

    def bombed?
        @bombed
    end

    def explored?
        @explored
    end

    def plant_bomb
        @bombed= true
    end

    def toggle_flag
        @flagged= !@flagged unless explored?
    end

    def neighbours
        adjacent_neighbours= DISHA.map do |idx,idy|
            [@pos[0] + idx, @pos[1] + idy]
        end.select do |row,col|
            [row,col].all? do |coord|
                coord.between?(0, @board.grid_size - 1)
            end
        end

        adjacent_neighbours.map{|pos| @board[pos]}
    end

    def adjacent_bomb_count
        neighbours.select(&:bombed?).count
    end

    def explore
        return self if flagged?
        return self if explored?
        @explored= true
        if !bombed? && adjacent_bomb_count==0
            neighbours.each(&:explore)
        end
        self    
    end

    def render
        bombs= adjacent_bomb_count
        if flagged?
            "F".red
        elsif explored?
            bombs == 0 ? BLOC.light_black : bombs.to_s.colorize(COLOR[bombs])
        else
            "*"
        end
    end

    def reveal
        # to fully show the board at the end of the game
        bombs= adjacent_bomb_count
        if flagged?
            bombed? ? "F".red : "f".light_red
        elsif bombed?
            explored? ? "X".light_yellow.on_red : "B".yellow
        else
            bombs == 0 ? BLOC.light_black : bombs.to_s.colorize(COLOR[bombs])
        end
    end

    def inspect
        {pos: @pos,
         bombed: bombed?,
         explored: explored?,
         flagged: flagged?}.inspect
    end
end