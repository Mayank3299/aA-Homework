require_relative 'MinMaxStackQueue'
require 'byebug'
def windowed_max_range(array, window)
    queue= MinMaxStackQueue.new
    best_range= nil
    
    array.each do |num|
        queue.enqueue(num)
        queue.dequeue if queue.size > window

        if queue.size == window
            current_range= queue.max - queue.min
            best_range= current_range if !best_range || current_range > best_range
        end
    end

    best_range
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8