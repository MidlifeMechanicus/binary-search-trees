module OrderTree
  def level_order
    # traverse the tree in breadth-first level order and yield each node to the provided block or  return an array of values if no block is given

    return if @root.nil?

    discovered = []
    discovered << @root
    output = [] unless block_given?

    while discovered.length > 0
      if block_given?
        yield(discovered[0].data)
      else
        output << discovered[0].data
      end
      discovered << discovered[0].left_node unless discovered[0].left_node.nil?
      discovered << discovered[0].right_node unless discovered[0].right_node.nil?
      discovered.shift
    end
    output
  end

  def inorder(current_node = root, &block)
    # traverse tree depth first in left-root-right order
    return [] if current_node.nil?

    left = inorder(current_node.left_node, &block)
    yield(current_node.data) if block_given?
    right = inorder(current_node.right_node, &block)
    left + [current_node.data] + right unless block_given?
  end

  def preorder
    # traverse tree depth first in root-left-right order
    return if @root.nil?

    discovered = []
    discovered << @root
    output = [] unless block_given?

    while discovered.length > 0
      current_node = discovered[-1]
      discovered.pop
      if block_given?
        yield(current_node.data)
      else
        output << current_node.data
      end
      discovered << current_node.right_node unless current_node.right_node.nil?
      discovered << current_node.left_node unless current_node.left_node.nil?
    end
    output
  end

  def postorder(current_node = root, &block)
    # traverse tree depth first in left-right-root order
    return [] if current_node.nil?

    left = inorder(current_node.left_node, &block)
    right = inorder(current_node.right_node, &block)
    yield(current_node.data) if block_given?
    left + right + [current_node.data] unless block_given?
  end
end
