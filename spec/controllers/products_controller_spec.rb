require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
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

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "should render new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #create" do
    context "with valid attributes" do
      it "returns redirect to index" do
        post :create, product: FactoryGirl.attributes_for(:product)
        expect(response).to redirect_to products_path
      end
      it "create a new product" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:product)
          response}.to change(Product, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "re-render the new method" do
        post :create, product: FactoryGirl.attributes_for(:invalid_product)
        expect(response).to render_template :new
      end
      it "does not save the new product" do
        expect{
          post :create, product: FactoryGirl.attributes_for(:invalid_product)
          response}.to_not change(Product, :count)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      product = FactoryGirl.create(:product)
      get :edit, id: product
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    before :each do
      @product = FactoryGirl.create(:product, name: 'Test Name', quantity: 10, value: 1000)
    end

    context "valid attributes" do
      it "located the requested @contact" do
        put :update, id: @product, product: {difference: 3}
        expect(assigns(:product)).to eq(@product)
      end
      it "changes @product's quantity" do
        put :update, id: @product,
            product: {difference: 3}
        @product.reload
        expect(@product.quantity).to eq(13)
      end
      it "redirects to the index page" do
        put :update, id: @product, product: {difference: 3}
        expect(response).to redirect_to products_path
      end
    end
    context "with invalid attributes" do
      it "does not save the product in the database" do
        put :update, id: @product, product: {difference: -30}, format: :html
        @product.reload
        expect(@product.quantity).to eq(10)
      end
      it "re-renders the :edit template" do
        put :update, id: @product, product: {difference: -30}, format: :html
        expect(response).to render_template :edit
      end
    end
  end

end
