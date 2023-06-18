FactoryBot.define do
  factory(:planet) do
    earth
    trait :earth do
      name { 'sun' }
      radius { 695508 }
      star { create(:star, :the_sun)}
    end
  end
end