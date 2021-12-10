class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }
  
  attr_reader :pegs

  def self.valid_pegs?(chars)
    return chars.all? {|char| POSSIBLE_PEGS.keys.include?(char.upcase)}
  end

  def self.random(length)
    random_pegs= Array.new(length) {POSSIBLE_PEGS.keys.sample}
    Code.new(random_pegs)
  end

  def self.from_string(user_pegs)
    arr=user_pegs.split("")
    Code.new(arr)
  end

  def initialize(chars)
    if Code.valid_pegs?(chars)
      @pegs = chars.map {|char| char.upcase}
    else
      raise "does not contain valid pegs"
    end
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    count=0
    guess.pegs.each_with_index {|color,i| count+=1 if color==@pegs[i]}
    count
  end

  def num_near_matches(guess)
    count=0
    guess.pegs.each_with_index {|color,i| count+=1 if @pegs.include?(color) && color!=@pegs[i]}
    count
  end

  def ==(guess)
    @pegs==guess.pegs
  end
end
