FactoryBot.define do
  factory :post do
    association :user
    association :book
    difficulty { 3 }
    content { "This is a sample post content." }
  end
end
