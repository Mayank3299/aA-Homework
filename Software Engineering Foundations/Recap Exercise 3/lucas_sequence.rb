def lucas_sequence(len)
    return [] if len==0
    return [2] if len==1
    return [2,1] if len==2

    seq= lucas_sequence(len-1)
    ele= seq[-1] + seq[-2]
    seq<<ele
    seq
end

p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]