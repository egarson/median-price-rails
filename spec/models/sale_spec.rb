require 'spec_helper'

describe Sale do
  it 'has item_id and paid attributes' do
	s = Sale.new(:item_id => 1, :paid => 2.34)
	s.item_id.should eq 1
	s.paid.should eq 2.34
  end
end
