FactoryBot.define do
  factory :comment do
    association :post

    user_name { FFaker::Internet.email }
    comment { FFaker::Lorem.sentence }
  end
end
