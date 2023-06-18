FactoryBot.define do
  factory(:star) do
    the_sun
    trait :the_sun do
      name { 'sun' }
      radius { 695508 }
    end
  end
end