class Node
  def initialize(value)
    @data = value
    @left_node = nil
    @right_node = nil
  end

  attr_accessor :data, :left_node, :right_node
end