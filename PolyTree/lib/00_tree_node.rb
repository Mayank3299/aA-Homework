class PolyTreeNode
    def initialize(value)
        @value= value
        @parent= nil
        @children=[]
    end

    def value
        @value
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def parent=(node)
        return if parent == node

        if parent
            parent.children.delete(self)
        end
        
        @parent= node
        node.children << self unless node.nil?
    end

    def add_child(child_node)
        child_node.parent= self
    end

    def remove_child(child_node)
        if child_node && !self.children.include?(child_node)
            raise "Tried to remove a node that isnt a child"
        end

        child_node.parent= nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            search= child.dfs(target_value)
            return search unless search.nil?
        end
        nil
    end

    def bfs(target_value)
        queue=[]
        queue << self
        until queue.empty?
            node= queue.shift
            return node if target_value == node.value
            node.children.each do |child|
                queue << child
            end
        end
        nil
    end
end