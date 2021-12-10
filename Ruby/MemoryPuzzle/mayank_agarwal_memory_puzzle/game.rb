require_relative "board.rb"
require_relative "human_player.rb"
require_relative "card.rb"
require_relative "computer_player.rb"
require "byebug"
class Game

    def initialize(size= 4, player)
        @board= Board.new(size)
        @player= player
        @prev_guessed_pos= nil
        @size= size
    end

    def play

        until @board.won?
            @board.render
            inp= get_input
            make_guess(inp)
        end

        puts "Congratulations! You won!"
    end

    def get_input
        pos= nil
        until pos && valid_pos?(pos)
            pos= @player.prompt
        end
        pos
    end

    def valid_pos?(pos)
        pos.is_a?(Array) &&
        pos.count == 2 &&
        pos.all? do |ele|
            ele >= 0 && ele < @size
        end
    end

    def make_guess(pos)
        revealed_value= @board.reveal(pos)
        sleep(0.5)
        @player.revealed_card(pos, revealed_value)
        @board.render

        compare_guess(pos)
        sleep(0.7)
        @board.render
    end

    def compare_guess(new_guessed_pos)

        unless check_duplicate(new_guessed_pos)
            if @prev_guessed_pos && @prev_guessed_pos != new_guessed_pos
                if match?(@prev_guessed_pos, new_guessed_pos)
                    @player.receive_match(@prev_guessed_pos, new_guessed_pos)
                else
                    puts "Try again XD"
                    [@prev_guessed_pos, new_guessed_pos].each {|pos| @board[pos].hide}
                end
                @prev_guessed_pos= nil
                @player.prev_guessed_pos= nil
            else
                @prev_guessed_pos= new_guessed_pos
                @player.prev_guessed_pos= new_guessed_pos
            end
        end
    end

    def match?(pos1, pos2)
        @board[pos1] == @board[pos2]
    end

    def check_duplicate(pos)
        !@board.revealed?(pos)
    end
end

if __FILE__ == $PROGRAM_NAME
    g= Game.new(4, ComputerPlayer.new(4))
    g.play
end
