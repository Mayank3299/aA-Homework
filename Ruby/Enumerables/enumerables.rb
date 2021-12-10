require "byebug"

class Array
    def my_each(&prc)
        self.length.times do |i|
            prc.call(self[i])
        end
        self
    end

    def my_select(&prc)
        new_arr=[]
        debugger
        self.my_each do |i|
            new_arr << i if prc.call(i)
        end
        new_arr 
    end

    def my_reject(&prc)
        new_arr=[]
        self.my_each do |i|
            new_arr << i if !prc.call(i)
        end
        new_arr
    end

    def my_any?(&prc)
        self.my_each do |i|
            return true if prc.call(i)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |i|
            return false if !prc.call(i)
        end
        true
    end

    def my_flatten
        flattened=[]
        self.my_each do |i|
            if i.is_a?(Array)
                flattened+= i.my_flatten
            else
                flattened << i
            end
        end
        flattened
    end

    def my_zip(*ele)
        arr= Array.new(self.length) {Array.new()}
        self.length.times do |i|
            arr[i] << self[i]
            ele.my_each do |array|
                arr[i]<< array[i]
            end
        end
        arr
    end

    def my_rotate(val=1)
        shift= val % self.length
        self.drop(shift) + self.take(shift) 
    end

    def my_join(sep="")
        str=""
        self.length.times do |i|
            str+= self[i]
            str+= sep unless i==self.length-1
        end
        str
    end

    def my_reverse
        arr=[]
        self.my_each do |ele|
            arr.unshift(ele)
        end
        arr
    end
end