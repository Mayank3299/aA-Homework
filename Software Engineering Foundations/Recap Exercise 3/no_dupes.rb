def no_dupes?(arr)
    hash= Hash.new(0)
    arr.each do |ele|
        hash[ele]+=1
    end
    new_arr=[]
    hash.each do |k,v|
        new_arr<<k if hash[k]==1
    end
    new_arr
end

p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            