require 'byebug'
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable


  def initialize
    @head = Link.new
    @tail = @head
    @head.next = nil
    @tail.prev = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail
  end

  def empty?
    @head.next.nil?
  end

  def get(key)
    link = first
    until link == nil
      return link.val if link.key == key
      link = link.next
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def insert(key, val)
    link = first
    until link == nil
      break if link.key == key
      link = link.next
    end

    if link
      link.val = val
      link
    else
      new_link = Link.new(key, val)
      @tail.next = new_link
      new_link.prev = @tail
      @tail = new_link
      new_link
    end
  end

  def remove(key)
    link = first
    until link == nil
      break if link.key == key
      link = link.next
    end

    return if link == nil

    link.prev.next = link.next
    link.next.prev = link.prev if link.next
    nil
  end

  def each(&prc)
    link = first
    until link == nil
      yield(link)
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  def move_link_to_tail(link)
    link.prev.next = link.next
    link.next.prev = link.prev
    @tail.next = link
    link.prev = @tail
    link.next = nil
    @tail = link
  end

end#class
