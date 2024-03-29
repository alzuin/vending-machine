class CoinsController < ApplicationController
  # Show a table with the summary of the coins inside the Vending Machine
  def index
    @coins = Coin.all
    respond_to do |format|
      format.html
      format.json do
        render @coins.to_json
      end
    end
  end

  # Display a form to add coins (one type, how many like)
  def edit
    @coin = Coin.find(params[:id])
  end

  # Add the coins in database
  def update
    @coin = Coin.find(params[:id])
    if @coin.update(coin_params)
      # Respond to html with a redirect and json
      respond_to do |format|
        format.html do
          flash[:notice] = 'Quantity added'
          redirect_to coins_path
        end
        format.json do
          render json: @coin.to_json
        end
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Error updating quantity'
          render :edit
        end
        format.json do
          render json: { errors: @coin.errors.full_messages }, status: 422
        end
      end
    end
  end

  private

  def coin_params
    params.require(:coin).permit(:difference)
  end
end
