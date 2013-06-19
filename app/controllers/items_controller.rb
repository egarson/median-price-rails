require Rails.root.join('app/common.rb')
#
# Entrypoint for HTTP calls to /items/*
#
class ItemsController < ApplicationController

  BAD_YEAR = "Bad year: expected scalar (e.g. 1999) or valid range (e.g. 2001-2013)"

  # Cater for all permutations of brand, year, and year range
  # GET /items/median.json[?[brand=<brand>][&year=<year|year-year>]]
  def median
	if params[:year] and !valid_years(params)
	  render :status => BAD_REQUEST_400, :json => { :error => BAD_YEAR, :year => params[:year] }
	  return
	end
	brand = params[:brand] || '%'
	years = params[:year].split('-').sort if params[:year] # ['1999','2001'], ['2013'], or ['ANY']
	years << years[0] if years && years.length == 1 # make range work with single date
	median = Item.median(brand, years)

	# render directly: this is just a simple service
	render :json => {
	  :median => median.to_f.round(2),
	  :brand => params[:brand] || ANY,
	  :year => params[:year] || ANY
	}
  end

  def valid_years(params)
	params[:year].match /^\d{4}(-\d{4})?$/
  end
  private :valid_years

  # GET /items/sold.json
  def sold
	brand = params[:brand] || '%'
	@items = Item.sold(brand)
	respond_with @items
  end

  # GET /items.json
  def index
    @items = Item.all
	respond_with @items
  end

  # POST /items
  def create
    @item = Item.new(params[:item])
	@item.save
	respond_with @item
  end

  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])
	@item.update_attributes(params[:item])
	respond_with @item
  end

  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
	respond_with @item
  end
end
