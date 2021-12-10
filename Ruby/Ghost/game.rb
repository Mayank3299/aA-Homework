require_relative "player.rb"
require "set"
class Game
    data= File.read("dictionary.txt").split
    DAT_DATA= data.to_set
    ALPHABET= Set.new('a'..'z')
    MAX_LOSS_COUNT= 5
    $previous_player= ""
    attr_reader :fragment, :losses

    def initialize(*players)
        @player=[]
        players.each do |player_data|
            @player << Player.new(player_data) 
        end
        @losses= Hash.new{|losses, player| losses[player]=0}
        @fragment= ""
    end

    def current_player
        @player.first
    end

    def next_player!
        @player.rotate!
        @player.rotate! until @losses[current_player] < MAX_LOSS_COUNT
    end

    def round_over?
        DAT_DATA.include?(@fragment)
    end
    
    def take_turn(player)
        puts "\n\nIts #{current_player.name}'s turn to enter"
        letter= nil
        until letter
            letter= player.guess(fragment)
            unless valid_play?(letter)
                player.alert_invalid_guess(letter)
                letter= nil
            end
        end
        update_frag(letter)
        puts "#{player.name.upcase} added the letter #{letter} to the fragment"
    end

    def valid_play?(choice)
        return false if !ALPHABET.include?(choice)
        potential_word= @fragment+choice
        word_check?(potential_word)
    end

    def word_check?(potential_word)
        DAT_DATA.any?{|word| word.start_with?(potential_word)}
    end

    def update_frag(char)
        if valid_play?(char) == true
            @fragment+= char
        else
            @fragment
        end
    end

    def play_round
        @fragment= ""
        display_standings
        until round_over?
            take_turn(current_player)
            $previous_player= current_player
            next_player!
        end
        @losses[$previous_player]+=1
    end

    def record(player)
        "GHOST".slice(0, @losses[player])
    end

    def display_standings
        puts "\n\n-----CURRENT STANDINGS-----"
        puts "#{'Player'.ljust(20, " ")}#{'G LEVEL'.rjust(5," ")}"
        puts "-" * 27
        @player.each do |player_inp|
            puts "#{player_inp.name.to_s.ljust(19, " ")} #{record(player_inp).to_s.rjust(5," ")}"
        end
        puts "-" * 27
    end

    def game_over?
        remaining_players == true
    end

    def remaining_players
        @losses.one? {|k,v| v!=5}
    end

    def run
        play_round until game_over?
        winner
    end

    def winner
        display_standings
        next_player!
        puts "---------GAME OVER---------"
        puts "\nThe winner of this game is #{current_player.name}!!"
    end
end

if $PROGRAM_NAME == __FILE__
    game= Game.new(*gets.chomp.split(" ").map(&:capitalize))
    game.run
end
