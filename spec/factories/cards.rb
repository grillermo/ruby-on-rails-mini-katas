FactoryBot.define do 
  factory :card do 
    token { |n| "#{Random.hex}#{n}" }
    last4 { 1234 }
  end
end

