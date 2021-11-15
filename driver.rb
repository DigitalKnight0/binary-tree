require_relative 'node'
require_relative 'tree'

tree = Tree.new
tree.build_tree(Array.new(15) { rand(1..100) })
tree.pretty_print
p tree.balanced?
puts tree.level_order
puts tree.preorder
puts tree.inorder
puts tree.postorder
tree.insert(104)
tree.insert(101)
tree.insert(191)
tree.insert(121)
tree.insert(141)
tree.pretty_print
p tree.balanced?
tree.rebalance
tree.pretty_print
p tree.balanced?
puts tree.level_order
puts tree.preorder
puts tree.inorder
puts tree.postorder
