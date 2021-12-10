class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word= Hangman.random_word
    @guess_word= Array.new(@secret_word.length,'_')
    @attempted_chars=[]
    @remaining_incorrect_guesses= 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true
    else
      return false
    end
  end

  def get_matching_indices(char)
    arr=[]
    @secret_word.each_char.with_index do |c,i|
      if c==char
        arr<<i
      end
    end
    arr
  end

  def fill_indices(char, arr)
    arr.each {|i| @guess_word[i]=char}
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    end

    @attempted_chars<<char
    arr=self.get_matching_indices(char)
    if arr.length>0  
      self.fill_indices(char, arr)
    else
      @remaining_incorrect_guesses-=1
    end
    true
  end

  def ask_user_for_guess
    puts "Enter a char:"
    char=gets.chomp
    self.try_guess(char)
  end

  def win?
    if @secret_word==@guess_word.join("")
      puts "WIN"
      true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses==0
      puts "LOSE"
      true
    else
      false
    end
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      true
    else
      false
    end
  end
end
