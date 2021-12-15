require_relative "Element.rb"
require_relative "PriorityQueue.rb"
require "byebug"
class Astar

    DISHA= [[-1 , 0],[1 , 0],[0 , -1],[0 , 1]]
    attr_reader :maze

    def initialize(filename)
        @maze= maze_initialize(filename)
        @start_point= find_starting_point
        @end_point= find_ending_point
    end
    
    def maze_initialize(filename)
        maze = []
        File.open(filename).each_line do |l|
            line = l.chomp.split("")
            maze << line
        end
        maze
    end

    def find_starting_point
        find_char("S")
    end

    def find_ending_point
        find_char("E")
    end

    def find_char(char)
        @maze.each_with_index do |line,i|
            return [i , line.index(char)] if line.index(char)
        end
    end

    def is_valid?(point)
        p_x, p_y= point
        not_negative= p_x >= 0 && p_y >= 0
        within_bounds= p_x < @maze.length && p_y < @maze[0].length
        not_negative && within_bounds
    end

    def not_wall?(point)
        x,y= point
        @maze[x][y] == "*"
    end

    def find_neighbours(point)
        neighbours=[]
        DISHA.each do |row,col|
            neighbour= [point[0] + row , point[1] + col]
            if is_valid?(neighbour) && !not_wall?(neighbour)
                neighbours << neighbour
            end
        end
        neighbours
    end

    def calc_heuristic(a,b)
        current_x, current_y= b
        goal_x, goal_y= a
        (goal_x - current_x).abs + (goal_y - current_y).abs
    end

    def maze_solver_astar
        queue = PriorityQueue.new
        queue << Element.new([@start_point[0],@start_point[-1]], 0)
        prev = Array.new(@maze.length) {Array.new(@maze[0].length, nil)}
        prev[@start_point[0]][@start_point[-1]]= true    
        cost_so_far =  Array.new(@maze.length) {Array.new(@maze[0].length,0)}
        cost_so_far[@start_point[0]][@start_point[-1]]= 0
        end_p= @end_point
        while !queue.empty?
            current= queue.shift
            if current == end_p
                break
            end
            neighbours= find_neighbours(current)
            neighbours.each do |neighbour|
                x,y = neighbour
                new_cost= cost_so_far[current[0]][current[-1]] + 1
                if (cost_so_far[x][y] == 0 || new_cost < cost_so_far[x][y]) && prev[x][y] == nil
                    cost_so_far[x][y] = new_cost
                    priority = new_cost + calc_heuristic(neighbour, end_p)
                    queue << Element.new(neighbour, priority)
                    prev[x][y]= current
                end
            end
        end
        prev
    end

    def get_path
        path= []
        prev = maze_solver_astar
        node = @end_point
        while node!= true
            path << node
            node= prev[node[0]][node[-1]]
        end
        path.reverse!
        if path[0] == @start_point
           return path
        end
        []
    end

    def get_dup(array)
        new_arr= []
        array.each do |sub_arr|
            new_arr << sub_arr.dup
        end
        new_arr
    end

    def print_path
        path= get_path
        new_maze= get_dup(@maze)
        path.each do |x,y|
            if new_maze[x][y] == " "
                new_maze[x][y]= "X"
            end
        end
        new_maze
    end

    def show_maze(maze)
        maze.each do |array|
            puts array.join
        end
        nil
    end

    def run
        puts "Current Maze is: "
        show_maze(@maze)
        puts "\nSolution to the maze is:"
        show_maze(print_path)
    end
end 

if $PROGRAM_NAME == __FILE__
    m= Astar.new("maze1.txt")
    m.run
end