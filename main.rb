require_relative 'lib/node.rb'
require_relative 'lib/tree.rb'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test_tree = Tree.new(array)
p test_tree
#p test_tree.root
test_tree.pretty_print