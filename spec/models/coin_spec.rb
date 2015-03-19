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

  it 'is invalid without a quantity' do
    expect(FactoryGirl.build(:coin, quantity: nil)).not_to be_valid
  end
  it 'is invalid with a negative quantity' do
    expect(FactoryGirl.build(:coin, quantity: -10)).not_to be_valid
  end
  it 'is invalid with a float quantity' do
    expect(FactoryGirl.build(:coin, quantity: 9.12)).not_to be_valid
  end
end
