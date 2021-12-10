def proper_factors(num)
    arr=[]
    (1...num).each do |factor|
        arr<<factor if num%factor==0
    end
    arr
end

def aliquot_sum(num)
    arr= proper_factors(num)
    arr.sum
end

def perfect_number?(num)
    sum= aliquot_sum(num)
    if sum==num
        true
    else
        false
    end
end

def ideal_numbers(n)
    count=0
    num=1
    arr=[]
    while count<n
        res= perfect_number?(num)
        if res==true
            arr<<num
            count+=1
        end
        num+=1
    end
    arr
end