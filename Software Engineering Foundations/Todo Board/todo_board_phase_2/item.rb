class Item
    def self.valid_date?(date_string)
        parts= date_string.split("-").map(&:to_i)
        year, month, day= parts
        return false if parts.length!=3
        return false if !(1..12).include?(month)
        return false if !(1..31).include?(day)
        true
    end

    attr_reader :deadline, :done
    attr_accessor :title, :description

    def initialize(title, deadline, description)
        @title= title
        if Item.valid_date?(deadline)
            @deadline= deadline
        else
            raise "Entered date is not valid! Aise ho chuka tumhara kaam!"
        end
        @description= description
        @done= false
    end

    def deadline=(new_deadline)
        if Item.valid_date?(new_deadline)
            @deadline= new_deadline
        else
            raise "Chacha sahi se daal lo..."
        end 
    end

    def toggle
        if @done == true
            @done= false
        else
            @done= true
        end
    end
end