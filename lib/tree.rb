require_relative 'node.rb'
class Tree
  attr_accessor :array, :root 

  def initialize(array)
    @array = array
    @root = build_tree(array)
  end 

  def build_tree(array)
    array = array.sort.uniq
    if array.empty?
      return nil
    end
    mid = (array.length / 2)
    root = Node.new(array[mid])
    root.left_node = build_tree(array.slice(0, mid))
    root.right_node = build_tree(array.slice(mid + 1..-1))
    root
  end 

  def insert(value)
    cur = @root
    prev = nil
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
    @root
  end 

  def delete(value)
    cur = @root
    prev = nil
  
    while cur != nil && cur.data != value
      prev = cur
      if cur.data > value
        cur = cur.left_node
      else
        cur = cur.right_node
      end
    end
  
    if cur == nil
      p "There is no node with this value" 
      return @root
    end

    cur_left = cur.left_node
    cur_right = cur.right_node

    if cur_left == nil && cur_right == nil 
      prev.left_node = nil
      prev.right_node = nil
      return @root
    end 
     
    if cur_left != nil
      if prev.data > cur.data
        prev.left_node = cur.left_node
      else
        prev.right_node = cur.left_node
      end 
    end

    if cur_right != nil
      if prev.data > cur.data
        prev.left_node = cur.right_node
      else 
        prev.right_node = cur.right_node
      end 
    end 

    if cur_left != nil && cur_right != nil
      right_side = cur.right_node

      while right_side.left_node != nil
        right_side_prev = right_side
        right_side = right_side.left_node
      end
    
      if right_side.left_node == nil
        cur.data = right_side.data
        cur.right_node = right_side.right_node
      else
        p right_side_prev
        p right_side
        p cur
        p prev
        right_side_prev.left_node = nil
        cur.data = right_side.data
        p cur
        #cur.right_node = right_side_prev
      end

      p cur.data
      p prev.data
    
      if cur.data > prev.data
        prev.right_node = cur
      else
        prev.left_node = cur
      end 

      

    end 

    
    
    return @root
  end
  

  right_side = cur_right
  right_side_prev = nil

  while right_side.left_node != nil
    right_side_prev = right_side
    right_side = right_side.left_node
  end

  if right_side_prev
    right_side_prev.left_node = nil
  end

  cur.data = right_side.data
  return @root

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end

end 



