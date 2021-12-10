class String
    def select(&prc)
        if prc.nil?
            return ""
        else
            new_str=""
            self.each_char do |char|
                new_str+=char if prc.call(char)
            end
        end
        new_str
    end
end

p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""