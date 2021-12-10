def element_count(arr)
    hash= Hash.new(0)
    arr.each do |num|
        hash[num]+=1
    end
    hash
end

def char_replace!(str, hash)
    str.each_char.with_index do |char, idx|
        if hash.keys.include?(char)
            str[idx]= hash[char]
        end
    end
    str
end

def product_inject(arr)
    arr.inject {|sum, ele| sum*ele}
end