class Timer
  attr_reader :now

  def initialize
    @now = Time.now.to_i
  end

  def diff(other)
    res = other.now - self.now
    show(res)
  end

  def show(result)
    "#{result} sec"
  end
end
