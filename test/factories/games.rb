FactoryBot.define do
  factory :game do
    sequence(:title) { |n| "ゲーム#{n}" }
  end
end
