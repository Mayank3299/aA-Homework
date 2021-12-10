# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        if self.length>0
            self.max-self.min
        else
            return nil
        end
    end

    def average
        return nil if self.empty?
        self.sum/(self.length*1.0)
    end

    def median
        return nil if self.empty?
        
        mid_index= self.length/2
        sorted= self.sort
        if self.length.odd?
            sorted[mid_index]
        else 
            (sorted[mid_index-1]+sorted[mid_index])/2.0
        end
    end
            
    def counts
        hash=Hash.new(0)
        self.each {|ele| hash[ele]+=1}
        hash
    end

    def my_count(val)
        count=0
        self.each {|ele| count+=1 if val==ele}
        count
    end 

    def my_index(val)
        self.each_with_index  {|ele,i| return i if val==ele}
        return nil 
    end
    
    def my_uniq
        new_arr=[]
        self.each {|ele| new_arr<<ele if !new_arr.include?(ele)}
        new_arr
    end

    def my_transpose
        new_arr=Array.new(self.length) {Array.new(self.length)}
        self.each_with_index do |sub_array , i|
            sub_array.each_with_index do |ele , j|
                new_arr[j][i]=ele
            end
        end
        new_arr
    end
end
