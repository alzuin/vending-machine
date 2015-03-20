class SellingsController < ApplicationController
  # Display the main page where an user can buy a product
  def index
    @products = Product.all
    @coins    = Coin.all
    @selling  = Selling.new
  end

  # Finalize the selling
  def create
    @product = Product.find(params[:selling][:product])
    @selling = @product.sellings.new(paid: params[:selling][:paid])
    if @selling.save
      respond_to do |format|
        format.html
        format.json do
          render json: @selling.to_json
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = 'Sorry there is a problem: '
          @selling.errors.full_messages.each do |msg|
            flash[:error] += msg +'; '
          end
          redirect_to root_path
        end
        format.json do
          render json: { errors: @selling.errors.full_messages }, status: 422
        end
      end
    end
  end
end
