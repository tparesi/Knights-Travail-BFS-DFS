class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise 'not a child' if !children.include?(child) && child
    child.parent = nil
  end

  def children
    # We dup to avoid someone inadvertently trying to modify our
    # children directly through the children array. Note that
    # `parent=` works hard to make sure children/parent always match
    # up. We don't trust our users to do this.
    @children.dup
  end

  def value
    @value
  end

  def parent=(mother)
    unless @parent == mother
      @parent._children.delete(self) if @parent
      @parent = mother
      self.parent._children << self if mother
    end
  end

  def dfs(target)
    return self if @value == target

    children.each do |child|
      result = child.dfs(target)
      return result if result
    end

    nil
  end

  def bfs(target)
    return self if target == @value
    queue = [self]
    cur_node = self

    until queue.empty?
      cur_node = queue.shift
      return cur_node if cur_node.value == target
      queue += cur_node.children
    end

    cur_node
  end

  def trace_path_back
    path_to_start = [self.value]
    current_node = self

    while current_node.parent
      current_node = current_node.parent
      path_to_start << current_node.value
    end

    path_to_start.reverse
  end

  protected
  # Protected method to give a node direct access to another node's
  # children.
  def _children
    @children
  end
end



















#end
