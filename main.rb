require_relative 'lib/node'
require_relative 'lib/tree'

def print_elements(tree)
  puts 'level order'
  p tree.level_order
  puts 'pre order'
  p tree.preorder
  puts 'in order'
  p tree.inorder
  puts 'post order'
  p tree.postorder
end

array = (Array.new(15) { rand(1..100) })
tree = Tree.new(array)
tree.pretty_print
puts 'Is the tree balanced?'
p tree.balanced?
print_elements(tree)

5.times do
  num = rand(101..300)
  tree.insert(num)
end

tree.pretty_print
puts 'Is the tree balanced?'
p tree.balanced?

tree.rebalance
tree.pretty_print
puts 'Is the tree balanced?'
p tree.balanced?
print_elements(tree)
