class Journey
  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    @entry_station = station
    @exit_station = nil
  end

  def end(station = nil)
    @exit_station = station
  end

  def complete?
    return true if entry_station != nil && exit_station != nil
    false
  end

  def fare
    Oystercard::MIN_AMOUNT
  end
end
