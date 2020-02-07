FactoryBot.define do
  factory :random_inventory, class: Inventory do
    name { Faker::Appliance.equipment }
    description { Faker::Lorem.sentence }
    quantity { Faker::Number.number(digits: 2) }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end