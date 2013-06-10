require 'spec_helper'

describe Item do
  it 'has mandatory brand and year attributes' do
	i = Item.create(:brand => 'merc', :year => 2011)
	i.sold.should == false
	i.brand.should == 'merc'
	i.year.should == 2011
  end

  it 'has an optional paid attribute which implies it has been sold' do
	i = Item.create(:brand => 'bmw', :year => 2012, :paid => 123.45)
	i.paid.should == 123.45
	i.sold.should == true
  end
end
