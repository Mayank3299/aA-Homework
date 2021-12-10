require "employee"

class Startup
    
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name= name
        @funding= funding
        @salaries= salaries
        @employees=[]
    end

    def valid_title?(title)
        if @salaries.keys.include?(title)
            return true
        else
            return false
        end
    end

    def >(startup)
        if self.funding > startup.funding
            return true
        else
            return false
        end
    end

    def hire(employee_name, title)
        if !valid_title?(title)
            raise "title is invalid"
        end
        @employees<<Employee.new(employee_name, title)
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding > @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding-=@salaries[employee.title]
        else
            raise "not enough money to pay salary"
        end
    end

    def payday
        @employees.each {|employee| pay_employee(employee)}
    end

    def average_salary
        total= 0
        @employees.each {|employee| total+= @salaries[employee.title]}
        total/(@employees.length*1.0)
    end 

    def close
        @employees.clear
        @funding=0
    end

    def acquire(startup)
        @funding+= startup.funding
        startup.salaries.each do |title, salary|
            if !@salaries.has_key?(title)
                @salaries[title]= salary
            end
        end
        @employees= @employees + startup.employees
        startup.close
    end
end
