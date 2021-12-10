require "./board.rb"
require "./human_player.rb"

class Game
    def initialize(p1, p2)
        @player1 = HumanPlayer.new(p1)
        @player2 = HumanPlayer.new(p2)
        @board = Board.new
        @current_player= @player1
    end

    def switch_turn
        if @current_player == @player1
            @current_player= @player2
        else
            @current_player= @player1
        end
    end

    def play
        while(@board.empty_positions?)
            @board.print
            position= @current_player.get_position
            @board.place_mark?(position, @current_player.mark)
            if @board.win?(@current_player.mark)
                puts "VICTORY FOR PLAYER #{@current_player.mark}"
                return
            else
                self.switch_turn
            end
        end

        puts "GAME OVER"
        puts "Sadly neither of you won so its a DRAAAAAW"
    end
end