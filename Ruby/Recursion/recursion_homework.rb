require "byebug"

def sum_to(n)
    if n==1
        return 1
    end
    
    if n<0
        return nil
    end

    n + sum_to(n-1)
end

#puts sum_to(-8)

def add_numbers(array)
    if array.length <= 1
        return array[0]
    end
    array[0] + add_numbers(array[1..-1])
end

# puts add_numbers([1,2,3,4]) # => returns 10
# puts add_numbers([3]) # => returns 3
# puts add_numbers([-80,34,7]) # => returns -39
# puts add_numbers([]) # => returns nil

def gamma_fnc(n)
    if n==1
        return n
    end
    if n<1
        return nil
    end
    (n-1) * gamma_fnc(n-1)
end

# puts gamma_fnc(0)  # => returns nil
# puts gamma_fnc(1)  # => returns 1
# puts gamma_fnc(4)  # => returns 6
# puts gamma_fnc(8)  # => returns 5040

def ice_cream_shop(flavors, favorite)
    return false if flavors.empty?
    return true if favorite == flavors[0]
    ice_cream_shop(flavors[1..-1],favorite)
end

# puts ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
# puts ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
# puts ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
# puts ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
# puts ice_cream_shop([], 'honey lavender')  # => returns false

def reverse(string)
    if string.length <=1
        return string
    end
    reverse(string[1..-1]) + string[0]
end

# puts reverse("house") # => "esuoh"
# puts reverse("dog") # => "god"
# puts reverse("atom") # => "mota"
# puts reverse("q") # => "q"
# puts reverse("id") # => "di"
# puts reverse("") # => ""