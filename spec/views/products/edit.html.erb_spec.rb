require 'rails_helper'

RSpec.describe "products/edit.html.erb", type: :view do
  before :each do
    @product = FactoryGirl.create(:product)
  end

  it 'display and h1 tag' do
    visit "/products/#{@product.id}/edit"
    expect(page).to have_selector 'h1'
  end
  it 'display a link to home page' do
    visit "/products/#{@product.id}/edit"
    expect(page).to have_link('Home', root_path)
  end
  it 'display a link to Product situation' do
    visit "/products/#{@product.id}/edit"
    expect(page).to have_link('Product situation', products_path)
  end
end
