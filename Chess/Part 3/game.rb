require_relative "board"
require_relative "human_player"

class Game
    def initialize
        @board = Board.new
        @display= Display.new(@board)
        @players = {
            white: HumanPlayer.new("Alex", :white, @display),
            black: HumanPlayer.new("Marty", :black, @display)
        }
        @current_player= :white
    end

    def play
        until @board.checkmate?(@current_player)
            begin
                start_pos, end_pos= @players[@current_player].make_move(display)
                @board.make_move(@current_player, start_pos, end_pos)

                swap_turn!
                notify_player
            rescue StandardError => e
                @display.notifications[:error] = e.message
                retry
            end
        end

        @display.render
        puts "#{@current_player} is checkmated"

        nil
    end

    def swap_turn!
        @current_player = (@current_player == :white ? :black : white)
    end

    def notify_player
        if @board.in_check?(@current_player)
            @display.notifications.set_check
        else
            @display.notifications.uncheck
        end
    end
end