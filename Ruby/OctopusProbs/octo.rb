def sluggish_octo(array)
    sorted= false
    len= array.length
    
    while !sorted
        sorted= true

        (0...len - 1).each do |idx|
            if array[idx].length > array[idx + 1].length
                array[idx], array[idx+1]= array[idx+1], array[idx]
                sorted= false
            end
        end
        len -=1
    end
    puts array[-1]
end

#sluggish_octo(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])

def dominant_octo(array)
    return array if array.length < 2

    middle= array.length / 2
    left_part= array.take(middle)
    right_part= array.drop(middle)
    merge(dominant_octo(left_part), dominant_octo(right_part))
end

def merge(left, right)
    arr=[]
    until left.empty? || right.empty?
        ele =  (left.first.length < right.first.length) ? left.shift : right.shift
        arr << ele
    end

    arr + left + right
end

#puts dominant_octo(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])[-1]

def clever_octo(array)
    max= array[0]
    (1...array.length).each do |idx|
        max= array[idx] if array[idx].length > max.length
    end
    max
end

#puts clever_octo(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])

def slow_dance(string, array)
    array.each_with_index do |element, index|
        return index if element == string
    end
end

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
# puts slow_dance("up", tiles_array)
# puts slow_dance("right-down", tiles_array)

def fast_dance(string, hash)
    return hash[string]
end

hash= {
    "up" => 0,
    "right-up" => 1,
    "right" => 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "up-left" => 7
}

puts fast_dance('down', hash)