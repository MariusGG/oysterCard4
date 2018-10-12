require 'pry'
require 'station'

class Oystercard
  attr_reader :balance, :entry_station, :journeys, :exit_station

  MAX_LIMIT = 90
  MIN_AMOUNT = 1
  PENALTY = 6

  def initialize
    @balance = 0
    @journeys = []
    @entry_station = nil
    @exit_station = nil
  end

  def top_up(amount)
    raise "Maximum balance £#{MAX_LIMIT} exceeded" if max?
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient balance, minimum amount is #{MIN_AMOUNT}" if @balance < 1
    @entry_station = station

  end
  def touch_out(station)
    @exit_station = station
    deduct(MIN_AMOUNT)
    @journeys << {@entry_station => @exit_station}
    @entry_station = nil
  end

  private

  def max?
    @balance >= MAX_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
  def in_journey?
    @entry_station != nil
  end

end
