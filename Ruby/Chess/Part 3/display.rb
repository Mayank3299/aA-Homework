require "colorize"
require_relative "cursor"

class Display

    attr_reader :cursor, :board, :notifications
    def initialize(board)
        @board= board
        @cursor= Cursor.new([0,0], board)
        @notifications= {}
    end

    def print_grid
        @board.grid.each_with_index do |rows, i|
            rows.each_with_index do |piece, j|
                color_option= check_color(i, j)
                print piece.to_s.colorize(color_option)
            end
            puts ""
        end
        nil
    end

    def check_color(i, j)
        if cursor.cursor_pos == [i, j] && cursor.selected
            bg = :light_green 
        elsif cursor.cursor_pos == [i, j]
            bg = :red
        elsif (i + j).odd?
            bg = :light_yellow
        else
            bg = :light_blue
        end
        {background: bg}
    end

    def render
        system("clear")
        puts "Use arrow keys or WSAD to move! "
        print_grid

        notifications.each do |_key, val|
            puts val
        end
    end

    def reset!
        @notifications.delete(:error)
    end

    def set_check
        @notifications[:check] = "Check"
    end

    def uncheck
        @notifications.delete(:check)
    end
end