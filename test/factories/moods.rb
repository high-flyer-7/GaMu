FactoryBot.define do
  factory :mood do
    sequence(:name) { |n| "曲調#{n}" }
  end
end
