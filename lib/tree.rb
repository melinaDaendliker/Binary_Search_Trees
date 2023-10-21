require_relative 'node'
class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array
    @root = build_tree(array)
  end

  def build_tree(array)
    array = array.sort.uniq
    return nil if array.empty?

    mid = (array.length / 2)
    root = Node.new(array[mid])
    root.left_node = build_tree(array.slice(0, mid))
    root.right_node = build_tree(array.slice(mid + 1..-1))
    root
  end

  def insert(value)
    cur = @root
    prev = nil
    until cur.nil?
      prev = cur
      cur = if cur.data > value
              cur.left_node
            else
              cur.right_node
            end
    end
    if prev.data > value
      prev.left_node = Node.new(value)
    else
      prev.right_node = Node.new(value)
    end
    @root
  end

  def delete(value, root = @root)
    # base case
    return root if root.nil?

    if root.data > value
      root.left_node = delete(value, root.left_node)
    elsif root.data < value
      root.right_node = delete(value, root.right_node)
    else
      p root
      if root.left_node.nil?
        return root.right_node
      elsif root.right_node.nil?
        return root.left_node
      else
        cur = root.right_node
        cur = cur.left_node while cur.left_node
        root.data = cur.data
        delete(cur.data, root.right_node)
      end
    end
    root
  end

  def find(value, _root = @root)
    prev = nil
    cur = @root
    while !cur.nil? && cur.data != value
      prev = cur
      cur = if cur.data > value
              cur.left_node
            else
              cur.right_node
            end
    end

    if cur.nil?
      'The value does not exist in this tree'
    else
      cur
    end
  end

  def level_order(root = @root)
    breadth_first_array = []
    queue = [root]

    while queue.length > 0
      cur = queue[0]
      breadth_first_array.push(cur.data)
      queue.push(cur.left_node) unless cur.left_node.nil?
      queue.push(cur.right_node) unless cur.right_node.nil?
      queue.shift
    end
    breadth_first_array
  end

  def preorder(root = @root)
    depth_first_array = []
    stack = [root]
    order_function(stack, depth_first_array)
  end

  def inorder(root = @root)
    depth_first_array = []
    root_value = root.data
    stack = [root.right_node, root_value, root.left_node]
    order_function(stack, depth_first_array, root_value)
  end

  def postorder(root = @root)
    depth_first_array = []
    root_value = root.data
    stack = [root_value, root.right_node, root.left_node]
    order_function(stack, depth_first_array, root_value)
  end

  def order_function(stack, depth_first_array, root_value = nil)
    while stack.length > 0
      cur = stack[-1]
      if cur == root_value
        depth_first_array.push(cur)
        stack.pop
      else
        depth_first_array.push(cur.data)
        stack.pop
        stack.push(cur.right_node) unless cur.right_node.nil?
        stack.push(cur.left_node) unless cur.left_node.nil?
      end
    end
    depth_first_array
  end

  def height(node)
    results = []

    return 0 if node.nil?
    return 0 if node.left_node.nil? && node.right_node.nil?

    left_side = height(node.left_node)
    right_side = height(node.right_node)

    results.push(left_side + 1)
    results.push(right_side + 1)
    results.max
  end

  def depth(node)
    cur = @root
    prev = nil
    counter = 0
    while cur.data != node.data
      prev = cur
      counter += 1
      cur = if cur.data > node.data
              cur.left_node
            else
              cur.right_node
            end
    end
    counter
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end
