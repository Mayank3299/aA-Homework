class MyQueue
  def initialize
    @store = []
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.length == 0
  end

  def enqueue(ele)
    @store << ele
  end

  def dequeue
    ele= @store.shift
    ele
  end
end