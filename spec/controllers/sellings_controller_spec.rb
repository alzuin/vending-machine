require 'rails_helper'

RSpec.describe SellingsController, type: :controller do
  before :each do
    Rails.application.load_seed # loading seeds
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "should render index template" do
      get :index
      expect(response).to render_template :index
    end
    it "populates an array of products" do
      products = FactoryGirl.create(:product)
      get :index
      expect(assigns(:products)).to eq([products])
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "returns http success" do
        product = FactoryGirl.create(:product, value: 10)
        post :index, selling: FactoryGirl.attributes_for(:selling, product: product.id)
        expect(response).to have_http_status(:success)
      end
      it "create a new selling" do
        product = FactoryGirl.create(:product, value: 10)
        expect {
          post :create, selling: FactoryGirl.attributes_for(:selling, product: product.id)
          response}.to change(Selling, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "doesn't create a new selling" do
        product = FactoryGirl.create(:product, value: 100000)
        expect {
          post :create, selling: FactoryGirl.attributes_for(:selling, product: product.id)
          response}.to_not change(Selling, :count)
      end
    end
  end
end