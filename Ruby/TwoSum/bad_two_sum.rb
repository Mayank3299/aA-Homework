def bad_two_sum?(array, target_sum)
    (0...array.length - 1).each do |idx|
        (idx + 1...array.length).each do |idx2|
            return true if (array[idx] + array[idx2]) == target_sum
        end
    end
    false
end

arr = [0, 1, 5, 7]
p bad_two_sum?(arr, 6) # => should be true
p bad_two_sum?(arr, 10) # => should be false