def palindrome?(str)
    str.each_char.with_index do |char,i|
        if char == str[-i-1]
            next
        else
            return false
        end
    end
    true
end

def substrings(str)
    arr=[]
    i=0
    while i<str.length
        slice=i
        while slice<str.length
            arr<< str[i..slice]
            slice+=1
        end
        i+=1
    end
    arr
end

def palindrome_substrings(str)
    new_arr= substrings(str)
    arr=[]
    new_arr.each do |string|
        if palindrome?(string) && string.length>1
            arr<<string
        end
    end
    arr
end