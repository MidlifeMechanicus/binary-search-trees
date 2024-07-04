# Class for creating nodes in binary search tree
class Node
  attr_accessor :data, :left_node, :right_node

  def initialize(value)
    @data = value
    @left_node = nil
    @right_node = nil
  end
end
