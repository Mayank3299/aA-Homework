def longest_streak(str)
    start= 0
    current=""
    max=""
    while start < str.length
        if str[start] == str[start+1]
            current+= str[start]
        else
            current+=str[start]
            if current.length >= max.length
                max= current
            end
            current=""
        end
        start+=1
    end
    max
end

p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'
