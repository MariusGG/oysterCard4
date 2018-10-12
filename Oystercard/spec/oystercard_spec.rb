require 'oystercard'
require 'pry'
describe Oystercard do

let(:entry_station) { double("Liverpool St")}
let(:exit_station) { double("Aldgate")}

context 'when initialized' do
  it 'has a balance of zero' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end
  it 'has an empty array of journeys' do
    expect(subject.journeys).to eq []
  end
end

describe '#top_up' do
  it 'tops up the card' do
    random_number = rand
    subject.top_up(random_number)
    expect(subject.balance).to eq random_number
  end
end

context 'at maximum balance' do
  it 'can not be topped up' do
    limit = Oystercard::MAX_LIMIT
    subject.top_up(90)
    expect { subject.top_up(1) }.to raise_error("Maximum balance £#{limit} exceeded")
  end
end

# describe '#deduct' do
#   it 'deducts from my card' do
#       random_number1 = rand
#       random_number2 = rand
#       subject.top_up(random_number1)
#       expect {subject.deduct(random_number2)}.to change {subject.balance}.by -random_number2
#     end
# end

 describe '#touch_in' do
   it "remembers the entry station" do
     subject.top_up(5)
     subject.touch_in(entry_station)
     expect(subject.entry_station).to eq entry_station
   end

 end



describe '#touch_out' do
  it 'deducts the min fare' do
    min_amount = Oystercard::MIN_AMOUNT
    subject.top_up(90)
    expect {subject.touch_out(exit_station)}.to change {subject.balance}.by -min_amount
  end
  it 'saves the exit station' do
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end
it 'saves the journey' do
  subject.top_up(10)
  subject.touch_in(entry_station)
  subject.touch_out(exit_station)
  expect(subject.journeys).to eq [{entry_station => exit_station}]
end
it 'resets the entry_station' do
  subject.top_up(10)
  subject.touch_in(entry_station)
  subject.touch_out(exit_station)
  expect(subject.entry_station).to eq nil
end
end
describe '#in_journey?' do
it 'is true after touch_in' do
  card = Oystercard.new
  card.top_up(10)
  card.touch_in(entry_station)
  expect(card.send(:in_journey?)).to be true
end

it 'is false after touch_out' do
  subject.top_up(10)
  subject.touch_in(entry_station)
  subject.touch_out(exit_station)
  expect(subject.send(:in_journey?)).to be false
end
end

context "customer doesn't have enough funds" do
  it "raises an error on touch in" do
    min_amount = Oystercard::MIN_AMOUNT
    subject.top_up(rand)
    expect {subject.touch_in(entry_station)}.to raise_error("Insufficient balance, minimum amount is #{min_amount}")
  end
end


end
