require 'rails_helper'

RSpec.describe "coins/edit.html.erb", type: :view do
  before :each do
    @coin = FactoryGirl.create(:coin)
  end

  it 'display and h1 tag' do
    visit "/coins/#{@coin.id}/edit"
    expect(page).to have_selector 'h1'
  end
  it 'display a link to home page' do
    visit "/coins/#{@coin.id}/edit"
    expect(page).to have_link('Home', root_path)
  end
  it 'display a link to coins' do
    visit "/coins/#{@coin.id}/edit"
    expect(page).to have_link('Coins situation', coins_path)
  end
end
