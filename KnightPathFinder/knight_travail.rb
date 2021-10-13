require_relative "../PolyTree/lib/00_tree_node.rb"
DELTA= [
    [-2,-1],
    [-2,1],
    [-1,2],
    [1,2],
    [2,1],
    [2,-1],
    [1,-2],
    [-1,-2]]
class KnightPathFinder
    
    def self.valid_moves(pos)
        possible_pos= DELTA.map {|row,col| [pos[0]+row , pos[1]+col]}
        #check for the valid positions
        valid_pos= possible_pos.select do |row,col|
            [row,col].all? do |coord|
                coord.between?(0,7)
            end
        end
        valid_pos 
    end

    def initialize(pos)
        @considered_positions=[pos]
        @root_node= PolyTree.new(pos)
        @start_pos= pos
        build_move_tree
    end

    def new_move_positions(pos)
        valid_pos= KnightPathFinder.valid_moves(pos)
        new_pos = valid_pos.select do |position|
            !@considered_positions.include?(position)
        end
        @considered_positions+= new_pos
        new_pos
    end

    def build_move_tree
        nodes= [@root_node]
        until nodes.empty?
            node= nodes.shift
            possible_nodes= new_move_positions(node.value)
            possible_nodes.each do |pos|
                child_node= PolyTree.new(pos)
                node.add_child(child_node)
                nodes << child_node
            end
        end
    end
end