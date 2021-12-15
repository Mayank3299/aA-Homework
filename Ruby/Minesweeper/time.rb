#Found a simpler way to do it so no use of this class

class TimeChecker
    def self.calc_time(start_t,end_t)
        secs= end_t - start_t
        hour= secs/3600
        minutes= (secs - (3600*hour))/60
        seconds= (secs -(3600*hour)-(minutes*60))
        [hour.to_i,":",minutes.to_i,":",seconds.to_i].join
    end  
end