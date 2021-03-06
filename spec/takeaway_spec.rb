require 'takeaway'
require 'sms'

describe Takeaway do
  subject(:takeaway) { described_class.new(menu: menu, order: order, sms: sms, config: {}) }

  let(:menu) { double(:menu, print: print_menu) }
  let(:order) { double(:order, total: 10.98) }
  let(:sms) { double("SMS", deliver: nil) }
  let(:print_menu) { "Pizza - £5.00" }
  let(:dishes) do
    { spring_roll: 0.99, 
      char_sui_bun: 3.99 }
  end
  before do 
    allow(order).to receive(:add)
  end
  it "shows the menu with prices" do
    expect(takeaway.print_menu).to eq(print_menu)
  end

  #need to add to order, have missed some elements out.

  it "can order some number of several available dishes" do
    expect(order).to receive(:add).twice
    takeaway.place_order(dishes)
  end

  it "knows the order total" do
    total = takeaway.place_order(dishes)
    expect(total).to eq(10.98)
  end

  it "sends an SMS when the order has been placed" do
    expect(sms).to receive(:deliver)
    takeaway.place_order(dishes)
  end
    
end
