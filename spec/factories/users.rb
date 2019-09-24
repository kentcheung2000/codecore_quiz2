FactoryBot.define do
  factory :user do
   
    name { Faker::Name.name}
    sequence(:email) {|n| "#{n}-#{ Faker::Internet.email}"}
    #password { Faker::Internet.password(12) }
    
    password {"supersecret"}
  end
end
