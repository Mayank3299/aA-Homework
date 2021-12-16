def phase_1(array)
    array.each do |num1|
        min= true
        array.each do |num2|
            min = false if num2 < num1
        end
        return num1 if min == true
    end
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#puts phase_1(list)

def phase_2(array)
    min= array.first
    array.each do |ele|
        min= ele if min > ele
    end
    min
end

#puts phase_2(list)