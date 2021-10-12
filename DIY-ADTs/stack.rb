class Stack

    attr_accessor :stack
    def initialize
        @stack=[]
    end

    def push(ele)
        @stack.unshift(ele)
    end

    def pop
        @stack.shift
    end

    def peek
        @stack[0]
    end
end