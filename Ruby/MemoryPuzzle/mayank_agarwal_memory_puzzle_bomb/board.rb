require_relative "card.rb"
require "colorize"
require "byebug"
class Board
    
    def initialize(size=4)
        @board= Array.new(size){Array.new(size)}
        @size= size
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
        num_of_pairs= ((@size**2) - @size)/2
        cards= Card.shuffle_cards(num_of_pairs)
        num_of_bombs= Array.new(@size,"*")
        bombs= Card.create_bombs(num_of_bombs)
        combo= cards + bombs
        combo.shuffle!
        arr=[]
        @board.each_index do |i|
            @board[i].each_index do |j|
                arr << [i,j]
            end
        end
        arr.shuffle!
        (0...arr.length).each do |i|
            row,col= arr[i]
            @board[row][col]= combo.pop
        end
    end

    def render
        system("clear")
        puts "  #{(0...@size).to_a.join(" ")}".red
        @board.each_with_index do |row,i|
            puts "#{i}".red + " #{row.join(" ")}"
        end
        nil
    end

    def show_bombs
        system("clear")
        puts "  #{(0...@size).to_a.join(" ")}".red
        @board.each_index do |i|
            print "#{i} ".red
            @board[i].each_index do |j|
                if self[[i,j]].face_value == "*"
                    print "* "
                else
                    print "  "
                end
            end
            puts ""
        end
        
    end

    def hide_bombs
        @board.each_index do |i|
            @board[i].each_index do |j|
                self[[i,j]].face_up= false if self[[i,j]].face_value == "*"
            end
        end
        nil
    end

    def won?
        @board.each_index do |i|
            @board[i].each_index do |j|
                if self[[i,j]].face_value != "*"
                    return false if !@board[i][j].revealed?
                end
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
end