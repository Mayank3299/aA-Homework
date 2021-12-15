require_relative "board.rb"
#require_relative "time.rb"
require "yaml"
class Game
    def initialize(size, bombs)
        @board= Board.new(size,bombs)
    end

    def play
        start_time, end_time=[0,0]
        start_time= Time.new
        until @board.win? || @board.lose?
            system("clear")
            puts @board.render

            action, pos= get_move
            perform_action(action,pos)
        end
        end_time= Time.new
        if @board.win?
            puts "\nYOU WON!!!!"
            #puts "\nTime taken- #{TimeChecker.calc_time(start_time,end_time)}"
            puts "\nTime taken- #{(end_time - start_time).to_i} seconds"
        elsif @board.lose?
            system("clear")
            puts @board.reveal
            puts "\nYOU LOST lol"
        end
    end

    def get_move
        puts "Please enter the action you want to perform and position where you intend to perform it."
        inp= gets.chomp.split(",")
        [inp[0],[inp[1].to_i, inp[2].to_i]]
    end

    def perform_action(action, pos)
        tile= @board[pos]
        
        case action
        when 'f'
            tile.toggle_flag
        when 'e'
            tile.explore
        when 's'
            save
            puts "Do you still want to play or exit the game?"
            puts "y- Yes / n- No"
            inp= gets.chomp
            case inp
            when 'y'
            when 'n'
                exit
            end
        end
    end

    def save
        puts "Enter a file name"
        filename= gets.chomp
        
        File.write(filename, YAML.dump(self))
    end
end

if $PROGRAM_NAME == __FILE__
    case ARGV.count
    when 0
        Game.new(9,10).play
    when 1
        YAML.load_file(ARGV.shift).play
    end
end

