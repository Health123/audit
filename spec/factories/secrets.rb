FactoryGirl.define do
  sequence :data do |n|
     "Data #{n}"
  end
  
  factory :secret do
    data { FactoryGirl.generate(:data) }
    user { |a| a.association(:user) }
  end
end