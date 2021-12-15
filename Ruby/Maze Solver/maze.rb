class Maze

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

    def maze_solver_bfs
        queue = []
        visited = Array.new(@maze.length) {Array.new(@maze[0].length, false)}
        prev = Array.new(@maze.length) {Array.new(@maze[0].length)}
        point_1 = @start_point
        visited[point_1[0]][point_1[-1]] = true
        queue << point_1
        while queue.length > 0
            node= queue.shift
            neighbours= find_neighbours(node)
            neighbours.each do |neighbour|
                x,y = neighbour
                if !visited[x][y]
                    queue << neighbour
                    visited[x][y]= true
                    prev[x][y]= node
                end
            end
        end
        prev
    end

    def get_path
        path= []
        prev = maze_solver_bfs
        node = @end_point
        while node!=nil
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
    m= Maze.new("maze1.txt")
    m.run
end