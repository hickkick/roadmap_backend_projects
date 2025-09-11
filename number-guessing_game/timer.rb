class Timer
  attr_reader :now

  def initialize
    @now = Time.now.to_i
  end

  def diff(other)
    other.now - self.now
  end

  def show(result)
    "#{result} sec"
  end
end
