def hipsterfy(str)
    i=str.length-1
    alpha="aeiou"
    while i>-1
        if alpha.include?(str[i])
            return str[0...i] + str[i+1..-1]
        end
        i-=1
    end
    str
end

def vowel_counts(str)
    alpha="aeiou"
    str= str.downcase
    hash=Hash.new(0)
    str.each_char do |char|
        if alpha.include?(char)
            hash[char]+=1
        end
    end
    hash
end

def caesar_cipher(str,num)
    alpha= "abcdefghijklmnopqrstuvwxyz"
    new_str=""
    str.each_char do |char|
        if alpha.include?(char)
            new_str+= alpha[(alpha.index(char) + num)%alpha.length]
        else
            new_str+=char
        end
    end
    new_str
end