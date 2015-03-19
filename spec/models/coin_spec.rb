require 'rails_helper'

RSpec.describe Coin, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:coin)).to be_valid
  end

  it 'is invalid without a size' do
    expect(FactoryGirl.build(:coin, size: nil)).not_to be_valid
  end
  it 'is invalid with a negative size' do
    expect(FactoryGirl.build(:coin, size: -10)).not_to be_valid
  end
  it 'is invalid with a float size' do
    expect(FactoryGirl.build(:coin, size: 9.21)).not_to be_valid
  end
  it 'is invalid with a size outside of range' do
    expect(FactoryGirl.build(:coin, size: 3)).not_to be_valid
  end
  it 'does not allow duplicate api_id' do
    FactoryGirl.create(:coin, size: '10' )
    expect(FactoryGirl.build(:coin, size: 10 )).not_to  be_valid
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
