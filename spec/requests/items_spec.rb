require 'spec_helper'
#
# Integration tests for Item JSON api rooted at /items
#
describe 'Items Requests' do

  before :each do Item.delete_all end
  after :each do check_headers(response) end
  let(:uri) { '/items.json' }

  describe 'GET /items.json' do
    it 'responds with 200 and expected basic headers' do
      get uri
      response.status.should be(OK_200)
    end
  end

  describe 'GET /items/sold.json' do
	it 'retrieves sold items' do
	  post uri, :item => { :brand => 'merc', :year => 2013 }
	  post uri, :item => { :brand => 'bmw', :year => 2012, :paid => 12.34 }
	  get '/items/sold.json'
	  items = JSON.parse(response.body)
	  items.length.should == 1
	  item = items[0]
	  item['brand'].should == 'bmw'
	  item['paid'].should == 12.34
	end
  end

  describe 'POST /items.json' do
	it 'can correctly create a new item' do
	  post uri, :item => { :brand => 'merc', :year => 2013 }
	  response.status.should == CREATED_201
	  item = Item.find_by_brand_and_year('merc', 2013)
	  item.should_not be_nil
	  item.year.should == 2013
	  item.brand.should == 'merc'
	end
  end

  describe 'PUT /items/<id>.json' do
	it 'updates an existing item' do
	  post uri, :item => { :brand => 'bmw', :year => 2023 }
	  item = Item.last
	  item.year.should == 2023 # sanity check (sc)
	  put "items/#{item.id}.json", :item => { :year => 2013 }
	  response.status.should == NO_CONTENT_204
	  updated = Item.last
	  updated.year.should == 2013
	  item.id.should == updated.id # ensure correct record updated!
	end
  end

  describe 'DELETE /items/<id>.json' do
	it 'deletes an item' do
	  post uri, :item => { :brand => 'yugo' }
	  item = Item.last
	  delete "/items/#{item.id}.json"
	  response.status.should == NO_CONTENT_204
	  Item.find_by_id(item.id).should be_nil
	end
  end
end
