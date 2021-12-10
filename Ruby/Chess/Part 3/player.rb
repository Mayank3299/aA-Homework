class Player
    attr_reader :name, :color, :display
    
    def initialize(name, color, display)
        @name = name
        @color = color
        @display = display
    end
end