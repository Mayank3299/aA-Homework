class Map
    def initialize
        @map=[]
    end

    def set(k,v)
        pos= @map.index{|pair| pair[0] == k}
        if pos
            @map[pos][1] = v
        else
            @map << [k,v]
        end
    end

    def get(k)
        @map.each do |pair|
            if pair[0]==k
                return pair[1]
            end
        end
        nil
    end

    def delete(k)
       val= get(k)
       @map.reject! {|pair| pair[0]==k}
    end

    def show
        deep_dup(@map)
    end

    def deep_dup(arr)
        arr.map {|pair| pair.is_a?(Array) ? deep_dup(pair) : pair}
    end
end 