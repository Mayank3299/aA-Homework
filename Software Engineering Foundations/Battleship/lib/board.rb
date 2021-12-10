class Board
  attr_reader :size

  def self.print_grid(grid)
    grid.each do |subarray|
       puts subarray.join(" ")
    end
  end
  
  def initialize(n)
    @grid= Array.new(n){Array.new(n, :N)}
    @size= n*n
  end

  def [](indices)
    @grid[indices[0]][indices[1]]
  end

  def []=(position, value)
    @grid[position[0]][position[1]]=value
  end

  def num_ships
    count=0
    @grid.each do |subarray|
        subarray.each do |ele|
            if ele == :S
                count+=1
            end
        end
    end
    count
  end

  def attack(position)
    if self[position] == :S
        self[position]= :H
        puts "you sunk my battleship!"
        return true
    else
        self[position]= :X
        return false
    end
  end

  def place_random_ships
    total_ships= @size*0.25
    while self.num_ships < total_ships
        row= rand(0...@grid.length)
        col= rand(0...@grid.length)
        position= [row, col]
        self[position]= :S
    end
  end

  def hidden_ships_grid
    new_arr= @grid.map do |subarray|
        subarray.map do |ele|
            if ele == :S
                :N
            else
                ele
            end
        end
    end
    new_arr
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end
end
