class Node
  attr_accessor :lchild, :value, :rchild

  def initialize(value = nil, lchild = nil, rchild = nil)
    @value = value
    @lchild = lchild
    @rchild = rchild
  end
end
