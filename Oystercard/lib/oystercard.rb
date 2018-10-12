require 'pry'
require 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journeys

  MAX_LIMIT = 90
  MIN_AMOUNT = 1
  PENALTY = 6

  def initialize(current_journey = Journey)
    @balance = 0
    @journeys = []
    @current_journey = current_journey
  end

  def top_up(amount)
    raise "Maximum balance £#{MAX_LIMIT} exceeded" if max?
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient balance, minimum amount is #{MIN_AMOUNT}" if @balance < 1
    @current_journey.new(station)

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
