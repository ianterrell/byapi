require 'matrix'
class Vector
  def normalize
    self.map{|i|i/self.r}
  end
end