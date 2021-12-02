def my_uniq(array)
    new_arr=[]

    array.each do |ele|
        new_arr << ele unless new_arr.include?(ele)
    end

    new_arr
end

def two_sums(array)
    pairs=[]

    (0...array.length).each do |i|
        (i+1...array.length).each do |j|
            pairs << [i,j] if array[i] + array[j] == 0
        end
    end

    pairs
end

def transpose(array)
    new_arr= Array.new(array.length) {Array.new(array.length)}

    (0...array.length).each do |i|
        (0...array.length).each do |j|
            new_arr[i][j]= array[j][i]
        end
    end

    new_arr
end

def pick_stocks(array)
    pair= nil
    hash= Hash.new
    array.each_index do |index|
        hash[array[index]] = index
    end

    array.sort!
    i=0
    j= array.length - 1
    while i < j
       first= array[i]
       last= array[j]
       return pair= [first, last] if hash[first] < hash[last]
       i += 1
    end

    nil
end