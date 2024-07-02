class Tree

  def initialize
    @root = nil
    @size = 0
  end

  attr_accessor :root

  def build_tree(array)
    # takes an array of data (e.g., [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed (don’t forget to sort and remove duplicates!). The #build_tree method should return the level-0 root node.
    array = tree_sort(array.sort.uniq)

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
    end
    @size += 1
  end

end