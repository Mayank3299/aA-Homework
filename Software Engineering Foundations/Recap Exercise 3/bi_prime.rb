def bi_prime?(num)
    (2..num/2).each do |factor|
        if (num%factor==0)
            return true if prime?(factor) && prime?(num/factor)
        end
    end
    false
end

def prime?(num)
    (2...num).each do |factor|
        if num%factor==0
            return false
        end
    end
    true
end

p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false