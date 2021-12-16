def largest_contiguous_subsum(array)
    result= []
    array.each_with_index do |num1, idx1|
        (idx1...array.length).each do |idx2|
            result << array[idx1..idx2]
        end
    end

    max= result.first.sum
    ans=[]
    result.each do |arr|
        max= arr.sum if arr.sum >= max
    end
    max
end

list = [2, 3, -6, 7, -6, 7]
#p largest_contiguous_subsum(list)

def largest_contiguous_subsum_2(array)
    largest= array.first
    current= array.first

    (1...array.length).each do |idx|
        current= 0 if current < 0
        current+= array[idx]
        largest= current if current > largest
    end

    largest
end

p largest_contiguous_subsum_2(list)