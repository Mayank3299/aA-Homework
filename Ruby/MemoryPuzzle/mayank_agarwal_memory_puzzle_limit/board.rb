require_relative "card.rb"
require "colorize"

class Board
    
    def initialize(size=4)
        @board= Array.new(size){Array.new(size)}
        @size= size
        @limit= size
        populate
    end

    def [](pos)
        row,col= pos
        @board[row][col]
    end

    def []=(pos,val)
        row,col= pos
        @board[row][col]= val
    end

    def populate
        num_of_pairs= (@size**2)/2
        cards= Card.shuffle_cards(num_of_pairs)
        @board.each_index do |i|
            @board[i].each_index do |j|
                @board[i][j] = cards.pop
            end
        end
    end

    def render
        system("clear")
        puts "  #{(0...@size).to_a.join(" ")}".red
        @board.each_with_index do |row,i|
            puts "#{i}".red + " #{row.join(" ")}"
        end
    end

    def won?
        @board.each_index do |i|
            @board[i].each_index do |j|
                return false if !@board[i][j].revealed?
            end
        end
        true
    end

    def reveal(guessed_pos)
        if revealed?(guessed_pos)
            puts "The card is already revealed"
        else
            self[guessed_pos].reveal
        end
        self[guessed_pos].face_value
    end

    def revealed?(pos)
        self[pos].revealed?
    end
    
    attr_reader :board
    attr_accessor :limit
end