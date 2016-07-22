class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    results = 0
    self.inject(results){|accum, el| accum * 31 + el.hash}
  end
end

class String
  def hash
    results = 0
    self.split("").map{|char| char.ord}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
