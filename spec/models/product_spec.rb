require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:product)).to be_valid
  end
  it 'is invalid without a name' do
    expect(FactoryGirl.build(:product, name: nil)).not_to be_valid
  end
  it 'is invalid without a quantity' do
    expect(FactoryGirl.build(:product, quantity: nil)).not_to be_valid
  end
  it 'is invalid with a negative quantity' do
    expect(FactoryGirl.build(:product, quantity: -10)).not_to be_valid
  end
  it 'is invalid with a float quantity' do
    expect(FactoryGirl.build(:product, quantity: 9.21)).not_to be_valid
  end
  it 'is invalid without a price' do
    expect(FactoryGirl.build(:product, price: nil)).not_to be_valid
  end
  it 'is invalid with a negative price' do
    expect(FactoryGirl.build(:product, price: -10)).not_to be_valid
  end
  it 'is invalid with a float quantity' do
    expect(FactoryGirl.build(:product, price: 9.12)).not_to be_valid
  end
end
