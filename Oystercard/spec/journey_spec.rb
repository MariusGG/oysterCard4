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

    it "should charge penalty fare if journey is not complete" do
      subject = Journey.new(station)
      subject.end
      expect(subject.fare).to eq Oystercard::PENALTY
    end
  end

  describe 'complete?' do
    it "should return true when there is an exit and entry station" do
      subject =Journey.new(station)
      subject.end(station_2)
      expect(subject.complete?).to eq true
    end

    it "should return false when there is no entry station" do
      subject =Journey.new
      subject.end(station_2)
      expect(subject.complete?).to eq false
    end

    it "should return false when there is no exit station" do
      subject =Journey.new(station)
      subject.end
      expect(subject.complete?).to eq false
    end
  end
end
