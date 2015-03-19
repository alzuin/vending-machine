require 'rails_helper'

RSpec.describe CoinsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "populates an array of coins" do
      coins = FactoryGirl.create(:coin)
      get :index
      expect(assigns(:coins)).to eq([coins])
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      coin = FactoryGirl.create(:coin)
      get :edit, id: coin
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    before :each do
      @coin = FactoryGirl.create(:coin, quantity: 10)
    end

    context "with valid attributes" do
      it "saves the coin in the database" do
        put :update, id: @coin, coin: FactoryGirl.attributes_for(:valid_update)
        @coin.reload
        expect(@coin.quantity).to eq(13)
      end
      it "redirects to the index page" do
        put :update, id: @coin, coin: FactoryGirl.attributes_for(:valid_update)
        response.should redirect_to :index
      end
    end
    context "with invalid attributes" do
      it "does not save the coin in the database" do
        put :update, id: @coin, coin: FactoryGirl.attributes_for(:invalid_update), format: :html
        @coin.reload
        expect(@coin.quantity).to eq(10)
      end
      it "re-renders the :edit template" do
        put :update, id: @coin, coin: FactoryGirl.attributes_for(:valid_update), format: :html
        response.should render_template :edit
      end
    end
  end

end
