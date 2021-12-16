def okay_two_sum?(array, target_sum)
    array.sort!
    left= 0
    right= array.length - 1
    while left < right
        res= array[left] + array[right]
        return true if res == target_sum

        if res < target_sum
            left += 1 
        else
            right -= 1
        end
    end
    false
end

arr = [0, 1, 5, 7]
#p okay_two_sum?(arr, 6) # => should be true
#p okay_two_sum?(arr, 10) # => should be false