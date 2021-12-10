def is_prime?(num)
    if num < 2
        return false
    end
    (2...num).each do |factor| 
        if num%factor==0
            return false
        end
    end
    true
end

def nth_prime(num)
    count=0
    n=1
    while count<num
         n+=1
         count+=1 if is_prime?(n)
    end
    n
end

def prime_range( min, max)
    arr=[]
    n=min
    while n<=max
        arr<<n if is_prime?(n)
        n+=1
    end
    arr
end