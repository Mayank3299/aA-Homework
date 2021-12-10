class Flight
    attr_reader :passengers

    def initialize(flight_number, capacity)
        @flight_number= flight_number
        @capacity= capacity
        @passengers= []
    end

    def full?
        if @passengers.length == @capacity
            true
        else
            false
        end
    end

    def board_passenger(passenger)
        if !self.full? && passenger.has_flight?(@flight_number)
            @passengers << passenger
        end
    end

    def list_passengers
        @passengers.map(&:name)
    end

    def [](number)
        @passengers[number]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end
end