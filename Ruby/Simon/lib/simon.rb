class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    puts "Your score was #{sequence_length - 1}"
    reset_game
  end

  def take_turn
      show_sequence
      require_sequence
      unless @game_over
        round_success_message
        @sequence_length += 1
      end
  end

  def show_sequence
    add_random_color
    system("clear")
    puts seq.join(" ")
    sleep(1)
    system("clear")
  end

  def require_sequence
    puts "Enter the sequence just shown to you separated by space- "
    @seq.each do |color|
      user_input= gets.chomp
      if color[0] != user_input
        @game_over= true
        break
      end
    end
    sleep(0.25)
  end

  def add_random_color
    color= COLORS.sample
    seq << color
  end

  def round_success_message
    puts "Good job, you won this round!"
  end

  def game_over_message
    puts "Khatam! TATA! BYE BYE!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
