require_relative 'lib/node.rb'
require_relative 'lib/tree.rb'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test_tree = Tree.new(array)
#p test_tree
#p test_tree.root
#test_tree.pretty_print

test_tree.insert(6)
#test_tree.pretty_print

test_tree.insert(35)
#test_tree.pretty_print

test_tree.insert(100)
#test_tree.pretty_print

test_tree.insert(40)
test_tree.pretty_print
test_tree.insert(7000)

#test_tree.delete(35)
#test_tree.delete(3)
#test_tree.delete(5)
#test_tree.delete(324)

#test_tree.pretty_print

#test_tree.delete(4)
#test_tree.pretty_print

found_node = test_tree.find(5)
#p found_node

p test_tree.level_order
p test_tree.preorder
p test_tree.inorder
p test_tree.postorder
node = test_tree.find(67)
p test_tree.height(node)
