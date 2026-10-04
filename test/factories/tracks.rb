FactoryBot.define do
  factory :track do
    sequence(:title) { |n| "楽曲#{n}" }
    game
  end
end
