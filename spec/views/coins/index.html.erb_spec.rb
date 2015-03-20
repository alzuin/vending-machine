require 'rails_helper'

RSpec.describe "coins/create.html.erb", type: :view do
  it 'display and h1 tag' do
    visit '/coins'
    expect(page).to have_selector 'h1'
  end
  it 'display a link to home page' do
    visit '/coins'
    expect(page).to have_link('Home', root_path)
  end
end
