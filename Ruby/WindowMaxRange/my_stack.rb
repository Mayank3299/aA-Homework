class MyStack
  def initialize
    @store = []
  end

  def peek
    @store[-1]
  end

  def size
    @store.length
  end

  def empty?   
    @store.length == 0
  end

  def pop
    ele= @store.pop
    ele
  end

  def push(ele)
    @store << ele
  end
end