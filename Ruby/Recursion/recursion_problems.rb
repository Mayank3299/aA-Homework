require "byebug"

#Problem 1: 

def sum_recur(array)
    return 0 if array.empty?
    sum_recur(array.drop(1)) + array.first
end

#Problem 2: 

def includes?(array, target)
    return false if array.empty?
    array.first == target || includes?(array.drop(1), target)
end

#p includes?([1,2,3,4],-1)

# Problem 3: 

def num_occur(array, target)
    return 0 if array.empty?
    count=  array.first == target ? 1 : 0
    count + num_occur(array.drop(1), target)
end

# Problem 4: 

def add_to_twelve?(array)
    return false if array.length < 2
    array[0] + array[1] == 12 || add_to_twelve?(array.drop(1))
end

#p add_to_twelve?([1,2,3,4,5,4])

# Problem 5: 

def sorted?(array)
    return true if array.length <=1
    return false if array[0] > array[1]
    sorted?(array.drop(1))
end

#p sorted?([1,2,3,2])

# Problem 6: 

def reverse(string)
    return "" if string.empty?
    reverse(string[1..-1]) + string[0]
end

#p reverse("mayank")
