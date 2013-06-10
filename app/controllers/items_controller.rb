require Rails.root.join('app/common.rb')
#
# Entrypoint for HTTP calls to /items/*
#
class ItemsController < ApplicationController

  PAID_NOT_NULL = ' paid is not null '
  AND_BRAND_LIKE = ' and brand like ? '
  AND_YEAR_IS = ' and year >= ? and year <= ? '
  BAD_YEAR = "Bad year: expected scalar (e.g. 1999) or valid range (e.g. 2001-2013)"

  # GET /items{,.json}
  def index
    @items = Item.all
	respond_with @items
  end

  # GET /items/1{,.json}
  def show
    @item = Item.find(params[:id])
	respond_with @item
  end

  # GET /items/sold{,.json}
  def sold
	brand = params[:brand] || '%'
	@items = Item.where(PAID_NOT_NULL + 'and brand like ?', brand)
	respond_with @items
  end

  def valid(params)
	params[:year].match /^\d{4}(-\d{4})?$/
  end

  # GET /items/median.json[?[brand=<brand>][&year=<year|year-year>]]
  def median
	if params[:year] and !valid(params)
	  render :status => BAD_REQUEST_400, :json => { :error => BAD_YEAR, :year => params[:year] }
	  return
	end
	brand = params[:brand] || '%'
	years = (params[:year] || ANY).split('-').sort # ['1999','2001'], ['2013'], or ['ANY']
	years << years[0] if years.length == 1 # make years[0] = years[1] so range works with single date

	stmt = PAID_NOT_NULL + AND_BRAND_LIKE
	stmt += AND_YEAR_IS if params[:year]
	avg = params[:year] ?
	  Item.where(stmt, brand, years[0], years[1]).average(:paid) :
	  Item.where(stmt, brand).average(:paid)

	render :json => {
	  :median => avg.to_f.round(2),
	  :brand => params[:brand] || ANY,
	  :year => params[:year] || ANY
	}
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  def create
    @item = Item.new(params[:item])
	@item.save
	respond_with @item
  end

  # PUT /items/1{,.json}
  def update
    @item = Item.find(params[:id])
	@item.update_attributes(params[:item])
	respond_with @item
  end

  # DELETE /items/1{,.json}
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
	respond_with @item
  end
end
