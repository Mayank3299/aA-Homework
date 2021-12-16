def two_sum?(array, target_sum)
    hash= Hash.new(0)
    array.each do |num|
        if hash.has_key?(num)
            return true
        else
            hash[target_sum - num] = num
        end
    end
    false
end

arr = [0, 1, 5, 7]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false

