def second_anagram?(first, second)
    arr1, arr2= first.split(''), second.split('')
    arr1.each do |char|
        index= arr2.find_index(char)
        return false unless index
        arr2.delete_at(index)
    end
    arr2.empty?
end

puts second_anagram?('mayank', 'mayank')