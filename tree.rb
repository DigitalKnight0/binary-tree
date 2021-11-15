module Methods
  def build_tree(arr)
    arr = arr.uniq.sort unless arr.empty?
    return arr[0] if arr.size < 1

    mid = arr.length / 2 if arr.length.odd?
    mid = (arr.length / 2) - 1 if arr.length.even?

    @root = Node.new(arr[mid], build_tree(arr[0...mid]), build_tree(arr[(mid + 1)...arr.length]))
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.rchild, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.rchild
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.lchild, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.lchild
  end

  def insert(val, node = @root)
    if val > node.value && node.rchild.nil?
      node.rchild = Node.new(val)
      return
    elsif val < node.value && node.lchild.nil?
      node.lchild = Node.new(val)
      return
    end

    if val > node.value
      node = node.rchild
    elsif val < node.value
      node = node.lchild
    else
      return 'The value already exists in the tree'
    end
    insert(val, node)
  end

  def delete(val)
    node = find(val)
    return 'No node found' if node.is_a? String

    parent = val == @root.value ? @root : find(find_parent(val)[0])
    if node.rchild.nil? && node.lchild.nil?
      val > parent.value ? parent.rchild = nil : parent.lchild = nil
      nil

    elsif node.rchild.nil? || node.lchild.nil?
      nextNode = node.rchild.nil? ? node.lchild : node.rchild
      val > parent.value ? parent.rchild = nextNode : parent.lchild = nextNode
      nil

    elsif !node.rchild.nil? && !node.lchild.nil?

      arr = inorder
      succ = arr[arr.index(val) + 1]
      delete(succ)
      node.value = succ

    end
  end

  def find(val, node = @root)
    return 'No such node found in the tree' if node.nil?
    return node if node.value == val

    val > node.value ? find(val, node.rchild) : find(val, node.lchild)
  end

  def levels(node = @root, level = 0, arr = [])
    return arr if node.nil?

    arr.push([]) if arr.length == level
    arr[level].push(node.value)
    levels(node.lchild, level + 1, arr)
    levels(node.rchild, level + 1, arr)
  end

  def level_order
    levels.flatten
  end

  def inorder(node = @root, arr = [])
    return arr if node.nil?

    inorder(node.lchild, arr)
    arr.push(node.value)
    inorder(node.rchild, arr)
  end

  def preorder(node = @root, arr = [])
    return arr if node.nil?

    arr.push(node.value)
    preorder(node.lchild, arr)
    preorder(node.rchild, arr)
  end

  def postorder(node = @root, arr = [])
    return arr if node.nil?

    postorder(node.lchild, arr)
    postorder(node.rchild, arr)
    arr.push(node.value)
  end

  def height(val)
    node = find(val)
    return 'No such node found' if node.is_a? String

    arr = levels(node)
    arr.size - 1
  end

  def depth(val, node = @root, count = 0)
    return 'No node found' if node.nil?
    return count if node.value == val

    val > node.value ? depth(val, node.rchild, count + 1) : depth(val, node.lchild, count + 1)
  end

  def balanced?
    left = height(root.lchild.value)
    right = height(root.rchild.value)
    (left - right).abs < 2
  end

  def rebalance
    arr = inorder
    @root = build_tree(arr)
  end

  private

  def find_parent(val, node = @root, arr = [])
    return root if root.value == val
    return if node.value == val

    if val > node.value
      find_parent(val, node.rchild, arr)
      arr << node.value
    else
      find_parent(val, node.lchild, arr)
      arr << node.value
    end
  end
end

class Tree
  include Methods
  attr_accessor :root

  def initialize
    @root = nil
  end
end
