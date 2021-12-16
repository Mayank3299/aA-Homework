def fourth_anagram?(first, second)
    hash1= Hash.new(0)
    hash2= Hash.new(0)

    first.each_char {|letter| hash1[letter] += 1}
    second.each_char {|letter| hash2[letter] += 1}

    hash1 == hash2
end

#p fourth_anagram?('mayank', 'mayank')

def fourth_anagram_one_hash?(first, second)
    hash= Hash.new(0)

    first.each_char {|letter| hash[letter] +=1}
    second.each_char {|letter| hash[letter] -= 1}

    hash.each_value.all? {|val| val == 0}
end

p fourth_anagram_one_hash?('mayank', 'mayank')