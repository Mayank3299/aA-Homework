class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    self[key.hash] << key
    @count +=1
    resize! if @count > num_buckets
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    return false unless include?(key)
    self[key.hash].delete(key)
    @count -=1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store= self.store
    @count= 0
    @store= Array.new(num_buckets * 2) {Array.new}
    old_store.flatten.each {|ele| insert(ele)}
  end
end
