class Timer
  attr_reader :now

  def initialize
    @now = Time.now.to_i
  end

  def diff(other)
    res = other.now - self.now
  end

  def self.format_time(seconds)
    hrs, rem = seconds.divmod(3600)
    mins, secs = rem.divmod(60)
    format("%02d:%02d:%02d", hrs, mins, secs)
  end
end
