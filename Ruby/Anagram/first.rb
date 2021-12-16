def first_anagram?(first, second)
    perms= find_perm(first)
    p perms
    perms.any? {|perm| perm==second}
end

def find_perm(string)
    return [string] if string.length == 1
    perms=[]
    first_char= string[0]
    perm= find_perm(string[1..-1])
    perm.each do |word|
        (0..word.length).each do |idx|
            perms << word[0...idx] + first_char + word[idx...word.length]
        end
    end
    perms
end

p first_anagram?("abc", "bac")