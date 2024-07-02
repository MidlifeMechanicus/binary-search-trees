require_relative "main/tree"
require_relative "main/node"

# array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

an_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

tree = Tree.new

p tree.build_tree(an_array)

tree.insert(5)
tree.insert(3)
tree.insert(9)

p tree
