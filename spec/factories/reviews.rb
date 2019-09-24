FactoryBot.define do
  factory :review do
    body { "MyText" }
    rating { 1 }
    idea { nil }
  end
end
