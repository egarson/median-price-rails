#
# A product is anything that can have a median price, such as a car.
#
class ProductsController < ApplicationController

  respond_to :html, :json

  # GET /products{,.json}
  def index
    @products = Product.all
	respond_with @products
  end

  # GET /products/1{,.json}
  def show
    @product = Product.find(params[:id])
	respond_with @product
  end

  # GET /products/new{,.json}
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products{,.json}
  def create
    @product = Product.new(params[:product])
	@product.save
	respond_with @product
  end

  # PUT /products/1{,.json}
  def update
    @product = Product.find(params[:id])
	@product.update_attributes(params[:product])
	respond_with @product
  end

  # DELETE /products/1{,.json}
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
	respond_with @product
  end
end
