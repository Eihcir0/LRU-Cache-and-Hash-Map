require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if include?(key)
    self[key.hash] << key
    @count +=1
    resize! if @count == num_buckets
  end

  def include?(key)
    self[key.hash].any?{|i| i==key}
  end

  def remove(key)
    self[key.hash].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    temp_arr = @store.flatten
    @store = Array.new(new_buckets){Array.new}
    @count = 0
    temp_arr.each do |el|
      insert(el)
    end
  end

end
