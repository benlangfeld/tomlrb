require 'forwardable'

module Tomlrb
  class LocalTime
    extend Forwardable

    def_delegators :@time, :hour, :min, :sec, :usec, :nsec

    def initialize(hour, min, sec)
      @time = Time.new(0, 1, 1, hour, min, sec, '-00:00')
      @sec = sec
    end

    def to_time(year, month, day, offset='-00:00')
      Time.new(year, month, day, @time.hour, @time.min, @sec, offset)
    end

    def to_s
      frac = (@sec - sec)
      frac_str = frac == 0 ? '' : "#{frac.to_s[1..-1]}"
      @time.strftime("%T") << frac_str
    end

    def ==(other)
      @time == other.to_time(0, 1, 1)
    end

    def inspect
      "#<#{self.class}: #{to_s}>"
    end
  end
end
