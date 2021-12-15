class Element

include Comparable
attr_accessor :val, :priority

    def initialize(val, priority)
        @val= val
        @priority= priority
    end

    def <=>(other)
        @priority <=> other.priority
    end

end
