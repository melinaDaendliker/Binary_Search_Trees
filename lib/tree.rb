require_relative 'node.rb'
class Tree
  attr_accessor :array, :root 

  def initialize(array)
    @array = array
    @root = build_tree(array)
  end 

  def build_tree(array)
    array = array.sort.uniq
    #p array
    if array.empty?
      return nil
    end
    mid = (array.length / 2)
    #p mid
    root = Node.new(array[mid])
    #p root
    #p array.slice(0, mid)
    #p array.slice(mid + 1..-1)
    root.left_node = build_tree(array.slice(0, mid))
    root.right_node = build_tree(array.slice(mid + 1..-1))
    root
  end 

  def insert(value)
    cur = @root
    prv = nil
    while cur != nil
      if cur.data > value
        prev = cur
        cur = cur.left_node
      else
        prev = cur
        cur = cur.right_node
      end
    end
    if prev.data > value
      prev.left_node = Node.new(value)
    else
      prev.right_node = Node.new(value)
    end
    root
  end 


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end

end 



