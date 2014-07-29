#a simple patch for Array#to_h when the ruby version is lower than 2.1.0
class Array
  def to_h
    h = {}
    self.each do |pair|
      h[pair[0]] = pair[1]
    end
    h
  end
end