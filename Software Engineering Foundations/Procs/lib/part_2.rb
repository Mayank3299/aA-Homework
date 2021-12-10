def reverser(str, &prc)
    prc.call(str.reverse)
end

def word_changer(str, &prc)
    arr= str.split(" ")
    arr.map! {|word| prc.call(word)}
    arr.join(" ")
end

def greater_proc_value(num, prc1, prc2)
    r1=prc1.call(num)
    r2=prc2.call(num)
    if r1>r2
        return r1
    else
        return r2
    end
end

def and_selector(arr, prc1, prc2)
    arr.select {|ele| prc1.call(ele) && prc2.call(ele)}
end

def alternating_mapper(arr, prc1, prc2)
    new_arr=[]
    arr.each_with_index do |ele,i|
        if i%2==0
            new_arr<<prc1.call(ele)
        else
            new_arr<<prc2.call(ele)
        end
    end
    new_arr
end