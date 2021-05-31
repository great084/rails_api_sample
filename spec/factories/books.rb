FactoryBot.define do
  factory :book do
    user { nil }
    title { "MyString" }
    author { "MyString" }
    description { "MyText" }
  end
end
