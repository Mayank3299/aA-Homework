# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require "byebug"

def largest_prime_factor(num)
    num.downto(2).each {|factor| return factor if num%factor==0 && prime?(factor)}
end

def prime?(num)
    return false if num<2
    (2...num).none? {|factor| num%factor==0}
end

def unique_chars?(str)
    hash= Hash.new(0)
    str.each_char {|char| hash[char]+=1}
    hash.each_value do |v|
        if v>1
            return false
        end
    end
    true
end

def dupe_indices(arr)
    hash=Hash.new {|h,k| h[k]=[]}
    arr.each_with_index do |ele,i|
        hash[ele]<<i
    end
    hash.select {|ele,i| i.length>1}
end
    
def ana_array(arr_1, arr_2)
    count1= ele_count(arr_1)
    count2= ele_count(arr_2)
    count1 == count2
end

def ele_count(arr)
    hash=Hash.new(0)
    arr.each {|ele| hash[ele]+=1}
    hash
end