require "./board.rb"
require "./human_player.rb"
require "./computer_player.rb"

class Game
    def initialize(size, hash_mark)
        @players= hash_mark.map do |k,v|
            v ? ComputerPlayer.new(k) : HumanPlayer.new(k) 
        end
        @board = Board.new(size)
        @current_player= @players.first
    end

    def switch_turn
        @current_player= @players.rotate!(1).first
    end

    def play
        while(@board.empty_positions?)
            @board.print
            position= @current_player.get_position(@board.legal_positions)
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