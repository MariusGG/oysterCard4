require 'station'

describe Station do

  subject { Station.new("Bank", 1) }

  it "gives station name" do
      expect(subject.name).to eq "Bank"
    end

  it "gives you the staions zone" do
    expect(subject.zone).to eq 1
  end


end
