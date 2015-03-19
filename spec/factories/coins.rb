FactoryGirl.define do
  factory :coin do |f|
    f.size 10
    f.quantity 15
  end

  factory :invalid_update, parent: :coin do |f|
    f.difference -30
  end

  factory :valid_update, parent: :coin do |f|
    f.difference 3
  end
end
