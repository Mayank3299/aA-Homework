require "./item.rb"
require "byebug"
CHECKMARK = "\u2713".force_encoding('utf-8') # pretty checkmark

class List
    def initialize(label)
        @label= label
        @items=[]
    end

    attr_accessor :label

    def add_item(title, deadline, description="")
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            true
        else
            false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        (0 <= index) && (index < self.size)
    end

    def swap(idx1, idx2)
        if self.valid_index?(idx1) && self.valid_index?(idx2)
            @items[idx1], @items[idx2]= @items[idx2], @items[idx1]
            true
        else
            false
        end
    end

    def [](index)
        return nil if !self.valid_index?(index)
        @items[index] 
    end

    def priority
        @items.first
    end

    def print
        puts "-".ljust(47, "-")
        puts " " * (24-(self.label.length/2)) + self.label.upcase
        puts "-".ljust(47, "-")
        puts "#{'Index'.ljust(5," ")} | #{'Item'.ljust(17," ")} | #{'Deadline'.ljust(10," ")} | Done"
        puts "-".ljust(47, "-")
        @items.each_with_index do |item,i|
            status = item.done ? CHECKMARK : ' '
            puts "#{i.to_s.ljust(5," ")} | #{item.title.ljust(17," ")} | #{item.deadline.ljust(10," ")} | [#{status}]"
        end
        puts "-".ljust(47, "-")
    end

    def print_full_item(index)
        item= self[index]
        status = item.done ? CHECKMARK : ' '
        if self.valid_index?(index)
            puts "-".ljust(47, "-")
            puts "#{item.title.ljust(19," ")} #{item.deadline.ljust(20," ")} [#{status}]"
            puts item.description
            puts "-".ljust(47, "-")
        end
    end

    def print_priority
        self.print_full_item(0)
    end

    def up(index, amount=1)
        if self.valid_index?(index)
            while index!=0 && amount>0
                swap(index, index-1)
                amount-=1
                index-=1
            end
            true
        else
            false
        end
    end

    def down(index, amount=1)
        if self.valid_index?(index)
            while amount>0 && index != self.size-1
                swap(index, index+1)
                amount-=1
                index+=1
            end
            true
        else
            false
        end 
    end

    def sort_by_date!
        @items.sort_by! {|item| item.deadline}
    end

    def toggle_item(index)
        item= self[index]
        item.toggle
    end

    def remove_item(index)
        return false if !self.valid_index?(index)
        @items.delete_at(index)
        true
    end

    def purge
        @items.delete_if(&:done)
    end
end