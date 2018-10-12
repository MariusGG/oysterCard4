require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:station_2) { double :station_2 }

  it "should initialize with an entry station" do
    subject = Journey.new(station)
    expect(subject.entry_station).to eq station
  end

  it "should have an exit station" do
    subject = Journey.new(station)
    subject.end(station_2)
    expect(subject.exit_station).to eq station_2
  end

  describe "#fare" do
    it "should return the minimum fare" do
      subject = Journey.new(station)
      subject.end(station_2)
      expect(subject.fare).to eq Oystercard::MIN_AMOUNT
    end
  end
end
