def third_anagram?(first, second)
    sorted_strings= [first, second].each do |str|
        str.split('').sort.join
    end

    sorted_strings[0] == sorted_strings[1]
end

p third_anagram?('mayank', 'mayank')