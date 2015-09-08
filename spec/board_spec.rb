require 'board'


describe Board do

  let(:ship){double(:ship, size: 2, location: "A1", orientation: "H")}
  let(:ship2){double(:ship, size: 2, location: "A2", orientation: "V")}
  let(:ship_big){double(:ship_big, size: 3, location: "A1", orientation: "H")}
  let(:ship_out){double(:ship_out, size: 1, location: "A3", orientation: "H")}
  let(:ship_off){double(:ship_off, size: 2, location: "A2", orientation: "H")}


  it 'is created with an array(ocean)' do
    is_expected.to respond_to :ocean
  end

  it 'ocean returns an array of length 4' do
    expect(subject.ocean.count).to eq 4
  end

  it 'responds to ship_place method with 1 (i.e. the ship) arguments' do
    expect(subject).to respond_to(:ship_place).with(1).argument
  end

  it 'we would expect to see the ship in the ocean' do
    subject.ship_place(ship)
    expect(subject.ocean).to eq [ship,ship,"B1","B2"]
  end

  it 'raises an error if ship is too big (size 3) for the board' do
    expect{ subject.ship_place(ship_big) }.to raise_error "Your ship is too big"
  end

  it 'raises an error if you place the ship outside of the board' do
    expect{ subject.ship_place(ship_out) }.to raise_error "Your ship is on the land"
  end

  it 'raises an error if your ship has any part outside the board' do
    expect{ subject.ship_place(ship_off) }.to raise_error "Part of your ship is on land"
  end

  it 'raises and error if your any part of your ship is on the same part of the ocean as another ship' do
    subject.ship_place(ship)
    expect{ subject.ship_place(ship2) }.to raise_error "You cannot place your ship on top of another ship"
  end

  it "we would like to be able to fire a shot" do
    is_expected.to respond_to :shoot
  end

  it "we would like the shot to have a coordinate" do
    expect(subject).to respond_to(:shoot).with(1).argument
  end

  it "we would expect to register a hit if the shot hits part of a boat" do
  subject.ship_place(ship)
  expect{subject.shoot("A1")}.to output("Hit!").to_stdout
  end

  it "we would expect to register a miss if the shot hits part of a boat" do
  subject.ship_place(ship)
  expect{subject.shoot("B2")}.to output("Miss!").to_stdout
  end

  it "we would like to know when we have sunk an opponent's ship" do
    subject.ship_place(ship)
    subject.shoot("A2")
    expect{subject.shoot("A1")}.to output("You have sunk my ship").to_stdout
  end




end
