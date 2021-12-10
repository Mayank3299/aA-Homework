require "./board.rb"
require "./human_player.rb"

class Game
    def initialize(size, *mark)
        @players= mark.map {|mark| HumanPlayer.new(mark)}
        @board = Board.new(size)
        @current_player= @players.first
    end

    def switch_turn
        @current_player= @players.rotate!(1).first
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