# PHASE 2
def convert_to_int(str)
  str.to_i
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class NoCoffeeError < StandardError
  def message
    puts "Thanks for providing coffee, have one more try"
  end
end

class NoFruitError < StandardError
  def message
    puts "Thanks for providing this fruit but I dont have this"
  end
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == 'coffee'
    raise NoCoffeeError
  else
    raise NoFruitError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue NoCoffeeError => e
    e.message
    retry
  rescue NoFruitError => e
    e.message
  end
end  

# PHASE 4

# class LessThan5 < StandardError
#   def message
#     puts "Atleast have 5 years of frienship before calling him your friend."
#   end
# end


class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new ("Atleast have 5 years of frienship before calling him your friend.") if yrs_known.to_i < 5
    raise ArgumentError.new ("How can you be a friend if you dont even tell his name") if name.length == 0
    raise ArgumentError.new ("No favoutite pasttimes, no best friends") if fav_pastime.length == 0
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


