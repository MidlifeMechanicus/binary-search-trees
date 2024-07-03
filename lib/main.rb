require_relative "main/tree"
require_relative "main/node"

# array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

an_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

tree = Tree.new

p tree.depth

p tree.build_tree(an_array)

node5 = tree.find(5)

p tree.depth(node5)

# p tree.level_order

# p tree.height
node8 = tree.find(8)

# p tree.height(node8)

p tree.depth(node8)

# tree.postorder { |data| puts data}
# 
# p tree.postorder
