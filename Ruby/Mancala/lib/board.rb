class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups= Array.new(14){Array.new}
    @name1= name1
    @name2= name2
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup,i|
      next if i == 6  || i == 13
      4.times do
        cup << :stone
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12 
    raise "Starting cup is empty" if cups[start_pos].empty? 
  end

  def make_move(start_pos, current_player_name)
    stones= @cups[start_pos]
    @cups[start_pos]= []

    cup_idx= start_pos
    until stones.empty?
      cup_idx+=1
      cup_idx=0 if cup_idx > 13
      if cup_idx == 6
        @cups[cup_idx] << stones.pop if @name1 == current_player_name
      elsif cup_idx == 13
        @cups[cup_idx] << stones.pop if @name2 == current_player_name
      else
        @cups[cup_idx] << stones.pop
      end
    end

    render
    next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt  
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups.take(6).all? {|cup| cup.empty?} ||
    @cups[7..12].all? {|cup| cup.empty?}
  end

  def winner
    player1= cups[6].count
    player2= cups[13].count
    if player1 == player2
      :draw
    else
      player1 > player2 ? @name1 : @name2
    end
  end
end
