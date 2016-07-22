require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket_list = @store[key.hash % num_buckets]
    bucket_list.include?(key)
  end

  def set(key, val)
    bucket_list = @store[key.hash % num_buckets]
    @count += 1 unless bucket_list.include?(key)
    bucket_list.insert(key, val)
    resize! if @count == num_buckets
  end

  def get(key)
    bucket_list = @store[key.hash % num_buckets]
    bucket_list.get(key)
  end

  def delete(key)
    bucket_list = @store[key.hash % num_buckets]
    bucket_list.remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each(&prc)
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    num_new_buckets = num_buckets * 2
    old_store = @store
    @store = Array.new(num_new_buckets) {LinkedList.new}
    @count = 0
    old_store.each do |bucket|
      until bucket.empty?
        key = bucket.first.key
        val = bucket.first.val
        set(key, val)
        bucket.remove(key)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
