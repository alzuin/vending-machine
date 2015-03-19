FactoryGirl.define do
  factory :product do |f|
    f.name     { Faker::Commerce.product_name }
    f.quantity { Faker::Number.number(3) }
    f.price    { Faker::Number.number(4) }
  end
end
