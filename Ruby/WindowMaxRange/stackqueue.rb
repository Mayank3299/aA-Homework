require_relative 'my_stack'

class StackQueue
    def initialize
        @in_stack= MyStack.new
        @out_stack= MyStack.new
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def empty?
        @in_stack.empty? && @out_stack.empty?
    end

    def enqueue(ele)
        @in_stack.push(ele)
    end

    def dequeue
        dequeueify if @out_stack.empty?
        @out_stack.pop
    end

    private
    def dequeueify
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end
end