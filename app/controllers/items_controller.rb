#
# Entrypoint for HTTP calls to /items/*
#
class ItemsController < ApplicationController

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

  # GET /items/sold.json
  def sold
	@items = Item.where('paid is not null')
	respond_with @items
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
