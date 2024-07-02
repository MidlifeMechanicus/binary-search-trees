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

  def delete(value)
    # return @root if @root.nil?
    # current_node = @root
    # previous_node = @root
    # until current_node.data == value

  end

  def help_delete(value, node = self.root)
    if node == nil
      return nil
    end
    if value < node.data
      node.left_node = help_delete(value, node.left_node)
    elsif value > node.data
      node.right_node = help_delete(value, node.right_node)
    else
      # This triggers where value == node.data
      if node.left_node != nil && node.right_node != nil
        temp_node = node
        # min_riht = 
      end
    end
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


end