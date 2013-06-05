#
# A Sale is an Item sold at a given price at a given time.
#
class SalesController < ApplicationController

  # GET /sales{,.json}
  def index
    @sales = Sale.all
	respond_with @sales
  end

  # GET /sales/1{,.json}
  def show
    @sale = Sale.find(params[:id])
	respond_with @sale
  end

  # GET /sales/new{,.json}
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
  end

  # POST /sales{,.json}
  def create
    @sale = Sale.new(params[:sale])
	# @sale.item_id = params[:item_id]
	@sale.save
	respond_with @sale
  end

  # PUT /sales/1{,.json}
  def update
    @sale = Sale.find(params[:id])
	@sale.update_attributes(params[:sale])
	respond_with @sale
  end

  # DELETE /sales/1{,.json}
  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
	respond_with @sale
  end
end
