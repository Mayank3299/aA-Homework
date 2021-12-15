class PriorityQueue 

    attr_accessor :elements
    def initialize
        @elements= []
    end

    def <<(element)
        @elements << element
    end 

    def shift
        ele_inde= @elements[0]
        @elements.sort!
        @elements.shift.val
    end

    def empty?
        @elements.length < 1
    end
end