FactoryGirl.define do
  factory :product do |f|
    f.name     { Faker::Commerce.product_name }
    f.quantity { Faker::Number.number(3) }
    f.value    { Faker::Number.number(4) }
  end

  factory :invalid_product, parent: :product do |f|
    f.name     nil
    f.quantity { Faker::Number.number(3) }
    f.value    { Faker::Number.number(4) }
  end
end
