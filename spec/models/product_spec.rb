require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:product)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:product, name: nil)).not_to be_valid
  end
  it 'does not allow duplicate name' do
    FactoryGirl.create(:product, name: 'test' )
    expect(FactoryGirl.build(:product, name: 'test' )).not_to  be_valid
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
  it 'is invalid with a float price' do
    expect(FactoryGirl.build(:product, price: 9.12)).not_to be_valid
  end

  it 'is invalid with a float difference' do
    expect(FactoryGirl.build(:product, difference: 9.21)).not_to be_valid
  end
  it 'is invalid with a non numeric difference' do
    expect(FactoryGirl.build(:product, difference: 'xx')).not_to be_valid
  end
  it 'add the correct quantity' do
    product = FactoryGirl.create(:product, quantity: 10)
    id = product.id
    product.update(difference: 5)
    expect(Product.find(id).quantity).to  eq(15)
  end
  it 'subtract the correct quantity' do
    product = FactoryGirl.create(:product, quantity: 10)
    id = product.id
    product.update(difference: -2)
    expect(Product.find(id).quantity).to eq(8)
  end
  it 'doesn\'t allow to subtract mote than the present quantity' do
    product = FactoryGirl.create(:product, quantity: 10)
    expect(product.update(difference: -20)).to eq(false)
  end
end
