require 'takeaway'

describe Takeaway do
  subject(:takeaway) { described_class.new(menu: menu, order: order) }

  let(:menu) { double(:menu, print: print_menu) }
  let(:order) { double(:order, total: 10.98) }
  let(:print_menu) { "Pizza - £5.00" }
  
# Can use two dishes
  let(:dishes) do
    { spring_roll: 0.99, 
      char_sui_bun: 3.99 }
  end

  it "shows the menu with prices" do
    expect(takeaway.print_menu).to eq(print_menu)
  end

  it "can order some number of several available dishes" do
    expect(order).to receive(:add).twice
    takeaway.place_order(dishes)
  end

  it "knows the order total" do
    allow(order).to receive(:add)
    total = takeaway.place_order(dishes)
    expect(total).to eq(10.98)
  end
    
end