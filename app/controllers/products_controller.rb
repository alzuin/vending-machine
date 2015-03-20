class ProductsController < ApplicationController

  # Display a summary of all products in the vending machine
  def index
    @products = Product.all
    respond_to do |format|
      format.html
      format.json do
        render @products.to_json
      end
    end
  end

  # Display a form to add a new product to the vending machine
  def new
    @product = Product.new
  end

  # Add a product in the vending machine
  def create
    @product = Product.create(product_params)
    if @product.save
      # Respond to html with a redirect and json
      respond_to do |format|
        format.html do
          flash[:notice] = 'Product added'
          redirect_to products_path
        end
        format.json do
          render json: product.to_json
        end
      end
    else
      # Respond to html with a redirect and json
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Error adding product'
          render :new
        end
        format.json do
          render json: { errors: @product.errors.full_messages }, status: 422
        end
      end
    end
  end

  # Display a form to increase the quantity of a product inside the vending machine
  def edit
    @product = Product.find(params[:id])
  end

  # Increase the quantity of a product inside the vending machine
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      # Respond to html with a redirect and json
      respond_to do |format|
        format.html do
          flash[:notice] = 'Quantity added'
          redirect_to products_path
        end
        format.json do
          render json: @product.to_json
        end
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Error updating quantity'
          render :edit
        end
        format.json do
          render json: { errors: @product.errors.full_messages }, status: 422
        end
      end
    end
  end

  # Delete a product
  def destroy
    product = Product.find(params[:id]).destroy
    if product
      # Respond to html with a redirect and json
      respond_to do |format|
        format.html do
          flash[:notice] = 'Product destroyed'
          redirect_to products_path
        end
        format.json do
          render status: 200
        end
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Error deleting product'
          render :edit
        end
        format.json do
          render json: { errors: product.errors.full_messages }, status: 422
        end
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :quantity, :value, :difference)
  end
end
