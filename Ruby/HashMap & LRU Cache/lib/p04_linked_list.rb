class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next= self.next if self.prev
    self.next.prev= self.prev if self.next
    self.prev= nil
    self.next= nil
    self
  end
end

class LinkedList
  include Enumerable
  
  attr_reader :head, :tail
  def initialize
    @head= Node.new
    @tail= Node.new
    @head.next= @tail
    @tail.prev= @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |node|
      if node.key == key
        return node.val
      end
    end

    nil
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    node= Node.new(key, val)
    @tail.prev.next= node
    node.prev= @tail.prev
    node.next= @tail
    @tail.prev= node

    node
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        return node
      end
    end
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end
  end

  def each
    current_node= @head.next 
    while current_node != @tail
      yield current_node
      current_node= current_node.next
    end 
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
