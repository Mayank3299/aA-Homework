require_relative 'my_stack'

class MinMaxStack
    def initialize
        @stack= MyStack.new
    end

    def peek
        @stack.peek[:value] unless empty?
    end

    def size
        @stack.size
    end

    def empty?
        @stack.empty?
    end

    def max
        @stack.peek[:max] unless empty?
    end

    def min
        @stack.peek[:min] unless empty?
    end

    def pop
        @stack.pop[:value] unless empty?
    end

    def push(val)
        @stack.push({
            value: val,
            max: new_max(val),
            min: new_min(val)
        })
    end

    private
    def new_max(val)
        empty? ? val : [max, val].max
    end

    def new_min(val)
        empty? ? val : [min, val].min
    end
end