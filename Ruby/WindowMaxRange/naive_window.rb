require 'byebug'
def windowed_max_range(array, window)
    
    current_max_range= nil
    (0..array.length - window).each do |idx|
        slice= array[idx...idx+window]
        current_range= slice.max - slice.min
        current_max_range= current_range if !current_max_range || current_range > current_max_range
    end
    current_max_range
end

# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) 
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) 
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) 
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) 

