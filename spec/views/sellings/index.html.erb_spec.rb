require 'rails_helper'

RSpec.describe "sellings/index.html.erb", type: :view do
  it 'display and h1 tag' do
    visit "/"
    expect(page).to have_selector 'h1'
  end
  it 'display a link to Change administration' do
    visit "/"
    expect(page).to have_link('Change administration', coins_path)
  end
  it 'display a link to Product situation' do
    visit "/"
    expect(page).to have_link('Product administration', products_path)
  end
end
