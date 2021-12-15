require_relative "tile.rb"
require "byebug"
require "colorize"
class Board
    
    attr_reader :grid_size

    def initialize(grid_size, num_bombs)
        @grid_size= grid_size
        @num_bombs= num_bombs

        generate_board
    end

    def [](pos)
        row,col= pos
        @grid[row][col]
    end

    def generate_board
        @grid= Array.new(@grid_size) do |row|
            Array.new(@grid_size) {|col| Tile.new(self,[row,col])}
        end

        plant_bombs
    end

    def plant_bombs
        total_bombs=0
        while total_bombs < @num_bombs
            pos= Array.new(2) {rand(@grid_size)}
            
            tile= self[pos]
            next if tile.bombed?
            tile.plant_bomb
            total_bombs+=1
        end
    end

    def reveal
        render(true)
    end

    def render(reveal= false)
        puts "  #{(0...9).to_a.join(" ")}".light_green
        @grid.map.with_index do |row,i|
            "#{i} ".light_green + row.map do |tile|
                reveal ? tile.reveal : tile.render
            end.join(" ")
        end.join("\n")
    end

    def win?
        @grid.flatten.all?{|tile| tile.bombed? != tile.explored?}
    end

    def lose?
        @grid.flatten.any?{|tile| tile.bombed? && tile.explored?}
    end
end