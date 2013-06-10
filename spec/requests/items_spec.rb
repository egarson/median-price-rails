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
	it 'retrieves the full complement of sold items' do
	  post uri, :item => { :brand => 'merc', :year => 2013 }
	  post uri, :item => { :brand => 'bmw', :year => 2012, :paid => 12.34 }
	  get '/items/sold.json'
	  items = JSON.parse(response.body)
	  items.length.should == 1
	  item = items[0]
	  item['brand'].should == 'bmw'
	  item['paid'].should == 12.34
	end

	it 'can retrieve sold items by brand' do
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

  describe 'GET /items/median.json' do
	let(:merc) { {:brand => 'merc', :year => 2013} }
	let(:bmw) { {:brand => 'bmw', :year => 2013} }
	let(:porsche)  { {:brand => 'porsche', :year => 1999, :paid => 8.0 } }

	it 'can retrieve the median price by brand' do
	  [2.0, 4.0].each { |price| post uri, :item => merc.merge(:paid => price) }
	  [4.0, 5.0].each { |price| post uri, :item => bmw.merge(:paid => price) }
	  post uri, :item => porsche
	  get '/items/median.json?brand=merc'
	  resp = JSON.parse(response.body)
	  resp['median'].should == 3.0 # only merc 'counts'
	  resp['brand'].should == 'merc'
	  resp['year'].should == ANY
	end

	it 'can retrieve the median price by year' do
	  [4.0, 5.0].each { |price| post uri, :item => merc.merge(:paid => price) }
	  [6.0, 7.0].each { |price| post uri, :item => bmw.merge(:paid => price) }
	  post uri, :item => porsche
	  get '/items/median.json?year=2013'
	  resp = JSON.parse(response.body)
	  resp['median'].should == 5.5 # only 2013 'counts'
	  resp['brand'].should == ANY
	  resp['year'].should == '2013'
	end

	it 'can retrieve the median price by brand and year' do
	  [1.0, 2.0].each { |price| post uri, :item => merc.merge(:paid => price) }
	  [3.0, 4.0].each { |price| post uri, :item => bmw.merge(:paid => price) }
	  post uri, :item => porsche
	  get '/items/median.json?brand=bmw&year=2013'
	  resp = JSON.parse(response.body)
	  resp['median'].should == 3.5 # only 2013 bmws 'count'
	  resp['brand'].should == 'bmw'
	  resp['year'].should == '2013'
	end

	it 'can retrieve the median price by brand and year range' do
	  { 2010 => 4.0, 2011 => 6.0, 2012 => 8.0 }.each do |year,price|
		post uri, :item => { :brand => 'merc', :year => year, :paid => price }
		post uri, :item => { :brand => 'porsche', :year => year, :paid => price*2 }
	  end
	  get '/items/median.json?brand=merc&year=2010-2011'
	  resp = JSON.parse(response.body)
	  resp['median'].should == 5.0 # only 2010-11 mercs count
	  resp['brand'].should == 'merc'
	  resp['year'].should == '2010-2011'
	end

	it 'returns a 400 given a garbage year or range', :err => true do
	  get '/items/median.json?brand=foo&year=garbage'
	  response.status.should == BAD_REQUEST_400
	  resp = JSON.parse(response.body)
	  resp.to_s.should match /error.*year.*garbage/
	end
  end

  describe 'POST /items.json' do
	it 'creates a new item with the given attributes' do
	  post uri, :item => { :brand => 'merc', :year => 2013 }
	  response.status.should == CREATED_201
	  item = Item.find_by_brand_and_year('merc', 2013)
	  item.should_not be_nil
	  item.year.should == 2013
	  item.brand.should == 'merc'
	  response.headers['Location'].should end_with "items/#{item.id}" # check 'connectedness'
	end
  end

  describe 'PUT /items/<id>.json' do
	it 'updates an existing item' do
	  post uri, :item => { :brand => 'bmw', :year => 2023 }
	  item = Item.last
	  item.year.should == 2023 # sanity check
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
