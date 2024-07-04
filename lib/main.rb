require_relative "main/tree"
require_relative "main/node"

array = Array.new(15) {rand(1..100)}

tree = Tree.new
tree.build_tree(array)
p tree.balanced?

p tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder

new_array = Array.new(5) {rand(101..200)}

new_array.each do |element|
  tree.insert(element)
end

p tree.balanced?
tree.rebalance
p tree.balanced?

p tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder