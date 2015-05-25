require './intro_algorithms'

class KnightPathFinder
  MOVE_DELTAS = [
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2],
    [-2, -1],
    [-2, 1],
    [2, -1],
    [2, 1]
  ]

  def self.valid_moves(pos)
    makes_position(pos).select { |pos| on_board?(pos) }
  end

  def initialize(start)
    @start = start
    @visited_positions = [start]
    @move_tree = build_move_tree(start)
  end

  def new_move_positions(pos)
    possible_moves = (self.class.valid_moves(pos) - @visited_positions)
    @visited_positions += possible_moves
    possible_moves
  end

  def build_move_tree(start)
    root_node = PolyTreeNode.new(start)
    queue = [root_node]

    until queue.empty?
      current_node = queue.shift
      position = current_node.value
      children = []
      new_move_positions(position).each do |child|
        child_node = PolyTreeNode.new(child)
        children << child_node
        current_node.add_child(child_node)
      end

      queue += children
    end

    root_node
  end

  def find_path(end_pos)
    pos_node = @move_tree.bfs(end_pos)
    pos_node.trace_path_back
  end

  private

  def self.makes_position(pos)
    row, col = pos

    MOVE_DELTAS.map do |x, y|
      [row + x, col + y]
    end
  end

  def self.on_board?(pos)
    pos.all? { |el| el.between?(0,7) }
  end

end






















#end
