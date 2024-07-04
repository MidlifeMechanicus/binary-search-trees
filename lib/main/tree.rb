class Tree
  def initialize
    @root = nil
    @size = 0
  end

  attr_accessor :root

  def build_tree(array)
    # takes an array of data (e.g., [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed (don’t forget to sort and remove duplicates!). The #build_tree method should return the level-0 root node.
    array = tree_sort(array.sort.uniq)
    array.each do |element|
      insert(element)
    end
  end

  def tree_sort(array)
    # These are our base cases
    return [] if array.length <= 0
    return array if array.length == 1

    sorted = []
    mid = array.length / 2

    sorted << array[mid]
    left = tree_sort(array[0..mid - 1])
    right = tree_sort(array[mid + 1..array.length - 1])

    sorted + left + right
  end

  def insert(value)
    if @root.nil?
      @root = Node.new(value)
    else
      current_node = @root
      previous_node = @root

      until current_node.nil?
        previous_node = current_node
        current_node = if value < current_node.data
                         current_node.left_node
                       else
                         current_node.right_node
                       end
      end
      if value < previous_node.data
        previous_node.left_node = Node.new(value)
      else
        previous_node.right_node = Node.new(value)
      end
      # Condsider recursive?
    end
    @size += 1
  end

  def delete(value, current_node = root)
    help_delete(value, current_node = root)
    @size -= 1
    current_node
  end

  def help_delete(value, current_node = root)
    return nil if current_node.nil?

    if value < current_node.data
      current_node.left_node = help_delete(value, current_node.left_node)
    elsif value > current_node.data
      current_node.right_node = help_delete(value, current_node.right_node)
    elsif !current_node.left_node.nil? && !current_node.right_node.nil?
      # This triggers where value == node.data
      min_right = find_min(current_node.right_node)
      current_node.data = min_right.data
      current_node.right_node = help_delete(min_right.data, current_node.right_node)
    elsif !current_node.left_node.nil?
      current_node = current_node.left_node
    elsif !current_node.right_node.nil?
      current_node = current_node.right_node
    else
      current_node = nil
    end
    current_node
  end

  def find_max(current_node = root)
    if current_node.nil?
      return nil
    elsif current_node.right_node.nil?
      return current_node
    end

    find_max(current_node.right_node)
  end

  def find_min(current_node = root)
    if current_node.nil?
      return nil
    elsif current_node.left_node.nil?
      return current_node
    end

    find_min(current_node.left_node)
  end

  def find(value, current_node = root)
    # accepts a value and returns the node with the given value
    if current_node.nil?
      nil
    elsif value == current_node.data
      current_node
    elsif value > current_node.data
      find(value, current_node.right_node)
    elsif value < current_node.data
      find(value, current_node.left_node)
    end
  end

  def level_order
    # traverse the tree in breadth-first level order and yield each node to the provided block or  return an array of values if no block is given

    # Insert block argument after function working

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

  def height(current_node = root)
    # accepts a node and returns its height, which is defined as the number of edges in longest path from a given node to a leaf node
    return - 1 if current_node.nil?

    # This is NOT what the examples say (ie, return 0)
    # However, I am finding that this counts NODES rather than EDGES and so overcounts by 1.
    # By returning -1 we cancel out the +1 in the final recursion, thus ACTUALLY returning 0.
    height_left = height(current_node.left_node)
    height_right = height(current_node.right_node)
    [height_left, height_right].max + 1
  end

  def depth(target_node = root, current_node = root)
    # accepts a node and returns its depth, which is defined as the number of edges in path from a given node to the tree’s root node

    return -1 if current_node.nil?
    return 0 if target_node == current_node

    depth_left = depth(target_node, current_node.left_node)
    return depth_left + 1 if depth_left >= 0

    depth_right = depth(target_node, current_node.right_node)
    return depth_right + 1 if depth_right >= 0

    -1
  end

  def balanced?
    # checks if the tree is balanced - ie, difference between heights of left subtree and right subtree of every node is not more than 1

    return true if @root.nil?

    def check_height(node)
      return 0 if node.nil?

      left_height = check_height(node.left_node)
      return -1 if left_height == -1

      right_height = check_height(node.right_node)
      return -1 if right_height == -1

      height_diff = (left_height - right_height).abs
      return -1 if height_diff > 1

      [left_height, right_height].max + 1
    end

    check_height(@root) != -1
  end

  def rebalance
    # rebalances an unbalanced tree
    array = level_order
    @root = nil
    @size = 0
    build_tree(array)
  end
end
