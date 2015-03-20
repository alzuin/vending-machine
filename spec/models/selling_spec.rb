require 'rails_helper'

RSpec.describe Selling, type: :model do
  before :each do
    Rails.application.load_seed # loading seeds
  end

  it 'has a valid factory' do
    @product=FactoryGirl.create(:product, quantity: 2, value: 10)
    expect(@product.sellings.create(FactoryGirl.attributes_for(:selling))).to be_valid
  end

  it 'fail if there are not enough products' do
    @product=FactoryGirl.create(:product, quantity: 0, value: 10)
    expect(@product.sellings.create(FactoryGirl.attributes_for(:selling))).to_not be_valid
  end

  it 'fail if there you don\'t paid at all' do
    @product=FactoryGirl.create(:product, quantity: 1, value: 10)
    expect(@product.sellings.create(FactoryGirl.attributes_for(:selling, paid: nil))).to_not be_valid
  end

  it 'fail if there you don\'t paid enough' do
    @product=FactoryGirl.create(:product, quantity: 1, value: 1000000)
    expect(@product.sellings.create(FactoryGirl.attributes_for(:selling))).to_not be_valid
  end
end
