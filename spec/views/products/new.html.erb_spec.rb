require 'rails_helper'

RSpec.describe "products/new.html.erb", type: :view do
  it 'display and h1 tag' do
    visit "/products/new"
    expect(page).to have_selector 'h1'
  end
  it 'display a link to home page' do
    visit "/products/new"
    expect(page).to have_link('Home', root_path)
  end
  it 'display a link to Product situation' do
    visit "/products/new"
    expect(page).to have_link('Product situation', products_path)
  end
end
