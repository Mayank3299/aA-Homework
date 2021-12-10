def partition(array, num)
    arr1=[]
    arr2=[]
    array.each do |ele|
        if ele<num
            arr1<<ele
        else
            arr2<<ele
        end
    end
    [arr1,arr2]
end

def merge(hash_1, hash_2)
    hash={}
    hash_1.each do |k,v|
        hash[k]=v
    end

    hash_2.each do |k,v|
        hash[k]=v
    end
    hash
end

def censor(str, arr)
    array= str.split(" ")
    alpha="aeiou"
    array.each do |word|
        if arr.include?(word.downcase)
            word.each_char.with_index do |char,i|
                if alpha.include?(char.downcase)
                    word[i]="*"
                end
            end
        end
    end
    array.join(" ")
end

def power_of_two?(num)
    product=1
    power=true
    while power && product<=num
        if product==num
            return power
        else
            product*=2
        end
    end
    !power
end