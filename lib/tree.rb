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

  def delete(value, root=@root)
    # base case
    if root == nil
      return root
    end 

    if root.data > value
      root.left_node = delete(value, root.left_node)
    elsif root.data < value
      root.right_node = delete(value, root.right_node)
    else
      p root
      if root.left_node == nil
        return root.right_node
      elsif root.right_node == nil
        return root.left_node
      else
        cur = root.right_node
        while cur.left_node
          cur = cur.left_node
        end 
        root.data = cur.data
        delete(cur.data, root.right_node)
      end 
    end 
   root
  end

  def find(value, root=@root)
    prev = nil
    cur = @root
    while cur != nil && cur.data != value
      prev = cur 
      if cur.data > value
        cur = cur.left_node
      else
        cur = cur.right_node
      end
    end

    if cur == nil
      "The value does not exist in this tree"
    else 
      cur
    end
  end 

  def level_order(root=@root)
    breath_first_array = []
    queue = [root]

    while queue.length > 0
      cur = queue[0]
      breath_first_array.push(cur.data)
      queue.push(cur.left_node) if cur.left_node != nil
      queue.push(cur.right_node) if cur.right_node != nil
      queue.shift
    end
    breath_first_array             
  end





  


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end

end 



