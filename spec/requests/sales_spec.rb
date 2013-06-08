require 'spec_helper'

#
# Integration tests for Sale JSON api rooted at /sales
#
describe "Sales Requests" do

  before :each do
	Item.delete_all
	Sale.delete_all
  end
  after :each do check_headers(response) end
  let(:uri) { '/sales.json' }

  describe 'GET /sales.json' do
    it 'responds with 200 and expected basic headers' do
      get uri
      response.status.should be(OK_200)
    end
  end

  describe 'POST /sales.json' do
	it 'can correctly create a new sale associated to a given item' do
	  # Although we could use POST here, ActiveRecord is used for diversity (items_spec uses post)
	  item = Item.create(:brand => 'merc', :year => 2013)
	  Item.find_by_brand_and_year('merc', 2013).should_not be_nil
	  post uri, :sale => { :item_id => item.id, :paid => 12.34 }
	  response.status.should == CREATED_201
	  # wanna see a funny Rails defect? uncomment this:
	  # puts response
	end
  end
end
