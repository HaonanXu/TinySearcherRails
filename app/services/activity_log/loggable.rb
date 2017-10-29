class Loggable

  def initialize(successor = nil)
    @successor = successor
  end

  def log(model, activities)
    raise NotImplementedError, 'Subclass has to implement this function'
  end
end