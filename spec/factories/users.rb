FactoryBot.define do
  factory :user do
    name { "Test User" }
    self_introduction { "Hello, I am a test user." }
    level { "初級エンジニア" }
  end
end
