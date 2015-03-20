require 'rails_helper'

RSpec.describe Coin, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:coin)).to be_valid
  end

  it 'is invalid without a size' do
    expect(FactoryGirl.build(:coin, value: nil)).not_to be_valid
  end
  it 'is invalid with a negative size' do
    expect(FactoryGirl.build(:coin, value: -10)).not_to be_valid
  end
  it 'is invalid with a float size' do
    expect(FactoryGirl.build(:coin, value: 9.21)).not_to be_valid
  end
  it 'is invalid with a size outside of range' do
    expect(FactoryGirl.build(:coin, value: 3)).not_to be_valid
  end
  it 'does not allow duplicate value' do
    FactoryGirl.create(:coin, value: '10' )
    expect(FactoryGirl.build(:coin, value: 10 )).not_to  be_valid
  end

  it 'is invalid without a quantity' do
    expect(FactoryGirl.build(:coin, quantity: nil)).not_to be_valid
  end
  it 'is invalid with a negative quantity' do
    expect(FactoryGirl.build(:coin, quantity: -10)).not_to be_valid
  end
  it 'is invalid with a float quantity' do
    expect(FactoryGirl.build(:coin, quantity: 9.12)).not_to be_valid
  end

  it 'is invalid with a float difference' do
    expect(FactoryGirl.build(:coin, difference: 9.21)).not_to be_valid
  end
  it 'is invalid with a non numeric difference' do
    expect(FactoryGirl.build(:coin, difference: 'xx')).not_to be_valid
  end
  it 'add the correct quantity' do
    coin = FactoryGirl.create(:coin, quantity: 10)
    id = coin.id
    coin.update(difference: 5)
    expect(Coin.find(id).quantity).to  eq(15)
  end
  it 'subtract the correct quantity' do
    coin = FactoryGirl.create(:coin, quantity: 10)
    id = coin.id
    coin.update(difference: -2)
    expect(Coin.find(id).quantity).to eq(8)
  end
  it 'doesn\'t allow to subtract mote than the present quantity' do
    coin = FactoryGirl.create(:coin, quantity: 10)
    expect(coin.update(difference: -20)).to eq(false)
  end
end
