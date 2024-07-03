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
    left = tree_sort(array[0..mid-1])
    right = tree_sort(array[mid+1..array.length-1])

    sorted + left + right
  end

  def insert(value)
    if @root == nil
      @root = Node.new(value)
    else
      current_node = @root
      previous_node = @root

      until current_node.nil?
        previous_node = current_node
        if value < current_node.data
          current_node = current_node.left_node
        else
          current_node = current_node.right_node
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

  def delete(value, current_node = self.root)
    help_delete(value, current_node = self.root)
    @size -= 1
    current_node
  end

  def help_delete(value, current_node = self.root)
    if current_node == nil
      return nil
    end
    if value < current_node.data
      current_node.left_node = help_delete(value, current_node.left_node)
    elsif value > current_node.data
      current_node.right_node = help_delete(value, current_node.right_node)
    else
      # This triggers where value == node.data
      if current_node.left_node != nil && current_node.right_node != nil
        min_right = find_min(current_node.right_node)
        current_node.data = min_right.data
        current_node.right_node = help_delete(min_right.data, current_node.right_node)
      elsif current_node.left_node != nil
        current_node = current_node.left_node
      elsif current_node.right_node != nil
        current_node = current_node.right_node
      else
        current_node = nil
      end
    end
    return current_node
  end

  def find_max(current_node = self.root)
    if current_node.nil?
      return nil
    elsif current_node.right_node.nil?
      return current_node
    end
    return find_max(current_node.right_node)
  end

  def find_min(current_node = self.root)
    if current_node.nil?
      return nil
    elsif current_node.left_node.nil?
      return current_node
    end
    return find_min(current_node.left_node)
  end

  def find(value, current_node = self.root)
    #accepts a value and returns the node with the given value
    if current_node.nil?
      return nil
    elsif value == current_node.data
      return current_node
    elsif value > current_node.data
      find(value, current_node.right_node)
    elsif value < current_node.data
      find(value, current_node.left_node)
    else
      return nil
    end
  end

  def level_order()
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
      unless discovered[0].left_node.nil?
        discovered << discovered[0].left_node
      end
      unless discovered[0].right_node.nil?
        discovered << discovered[0].right_node
      end
      discovered.shift
    end
    output
  end

  def inorder
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
      unless current_node.right_node.nil?
        discovered << current_node.right_node
      end
      unless current_node.left_node.nil?
        discovered << current_node.left_node
      end
    end
    output
  end

  def preorder
    # traverse tree depth first in left-root-right order
  end

  def postorder
    # traverse tree depth first in left-right-root order
  end

  def height
    # accepts a node and returns its height, which is defined as the number of edges in longest path from a given node to a leaf node
  end

  def depth
    # accepts a node and returns its depth, which is defined as the number of edges in path from a given node to the tree’s root node
  end

  def balanced?
    # checks if the tree is balanced - ie, difference between heights of left subtree and right subtree of every node is not more than 1
  end

  def rebalance
    # rebalances an unbalanced tree
  end


end