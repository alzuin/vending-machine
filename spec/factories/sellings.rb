FactoryGirl.define do
  factory :selling do |f|
    f.paid   {{"1"=>"0", "2"=>"0", "5"=>"0", "10"=>"0", "20"=>"0", "50"=>"0", "100"=>"0", "200"=>"1"}}
    f.change nil
  end

end
