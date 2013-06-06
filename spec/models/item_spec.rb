require 'spec_helper'

describe Item do
  it 'has brand and year attributes' do
	i = Item.new(:brand => 'merc', :year => 2011)
	i.brand.should eq 'merc'
	i.year.should eq 2011
  end
end
