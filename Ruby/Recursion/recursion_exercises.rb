require "byebug"
def range(start,ending)
    if ending <= start
        return []
    end
    arr=[]
    arr << start
    arr + range(start+1, ending)
end 

#p range(1,5)


def recursive_sum(array)
    return array.first if array.length == 1
    return [] if array.length<1
    array[0] + recursive_sum(array[1..-1])
end

#puts recursive_sum([1,2,3,4,5,6,-21])

def iterative_sum(array)
    sum=0
    array.each{|ele| sum+=ele}
    sum
end

# puts iterative_sum([12,3,45,6,7])

def exp1(power, num)
    if power == 0
        return 1
    end
    num * exp1(power-1, num)
end

# p exp1(4,3)

def exp2(power, num)
    if power==0
        return 1
    end
    if power.even?
        exp2(power/2, num) * exp2(power/2, num)
    else
        num * exp2(power/2, num) * exp2(power/2, num)
    end
end

#p exp2(6,3)

def deep_dup(array)
    new_arr=[]
    array.each do |ele|
        if ele.is_a?(Array)
            new_arr+= deep_dup(ele)
        else
            new_arr << ele
        end
    end
    new_arr
end

#p deep_dup([1, [2], [3, [4]]])

def iterative_fib(n)
    return [] if n==0
    return [0] if n==1
    arr=[0,1]
    while arr.length < n
        arr << arr[-2]+arr[-1]
    end
    arr
end

# p iterative_fib(6)

def recursive_fib(n)
    return [0,1].take(n) if n<=2
    prev_fib= recursive_fib(n-1)
    num= prev_fib[-1] + prev_fib[-2]
    prev_fib << num
end

# p recursive_fib(6)

def binary_search(array,ele)
    
    return nil if array.empty?
    middle= array.length/2
    if ele == array[middle]
        return array.index(ele)
    elsif ele < array[middle]
        binary_search(array[0...middle],ele)
    else
        middle+1 + binary_search(array[middle+1...array.length],ele) if !binary_search(array[middle+1...array.length],ele).nil?
    end
end

# puts binary_search([1, 2, 3], 1) # => 0
# puts binary_search([2, 3, 4, 5], 3) # => 1
# puts binary_search([2, 4, 6, 8, 10], 6) # => 2
# puts binary_search([1, 3, 4, 5, 9], 5) # => 3
# puts binary_search([1, 2, 3, 4, 5, 6], 6) # => 5
# puts binary_search([1, 2, 3, 4, 5, 6], 0) # => nil
# puts binary_search([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(array)
    
    return array if array.length<2
    middle= array.length/2
    left_side= array.take(middle)
    right_side= array.drop(middle)
    sorted_left= merge_sort(left_side)
    sorted_right= merge_sort(right_side)
    merger(sorted_left, sorted_right)
end

def merger(arr1,arr2)
    arr=[]
    until arr1.empty? || arr2.empty?
        ele= (arr1.first < arr2.first) ? arr1.shift : arr2.shift
        arr << ele
    end

    arr + arr1 + arr2
end

# p merge_sort([1,6,2,7,3,9])

def subsets(array)
    return [[]] if array.empty?
    subs= subsets(array.take(array.count-1))
    subs.concat(subs.map{|ele| ele + [array[-1]]})
end

#p subsets([1,2,3])

def permutations(array)
    return [array] if array.length <= 1
    first= array.shift
    perms= permutations(array)
    total_perms=[]
    perms.each do |perm|
        (0..perm.length).each do |i|
            total_perms << perm[0...i] + [first] + perm[i..-1]
        end
    end
    total_perms
end

#p permutations([1,2,3])

def greedy_make_change(change,denominations)
    arr=[]
    i=0
    while change!=0
        if denominations[i] <= change
            change-= denominations[i]
            arr << denominations[i]
        else
            i+=1
        end
    end
    arr
end

#p greedy_make_change(24,[10,7,1])

def recursive_greedy_make_change(change, denominations)
    arr=[]
    if denominations.first <= change
        change-= denominations.first
        arr << denominations.first
        arr+= recursive_greedy_make_change(change, denominations)
    else
        arr += recursive_greedy_make_change(change, denominations[1..-1])
    end
    arr
end

#p greedy_make_change(24,[10,7,1])

def make_better_change(amount, denominations)
    return [] if amount == 0

    best_change= nil
    denominations.each do |coin|
        next if coin > amount

        change_remaining= make_better_change(amount-coin, denominations)
        change= [coin] + change_remaining

        if best_change.nil? || change.count < best_change.count
            best_change= change
        end
    end
    best_change
end

p make_better_change(14, [10,7,1])
