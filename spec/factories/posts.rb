FactoryBot.define do 
  factory :post do
    association :user 

    user_name { FFaker::Internet.email }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.png')) }
    description { FFaker::Lorem.sentence }

    trait(:with_invalid_image) do
      image{ Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.txt')) }
    end
  end
end 
    