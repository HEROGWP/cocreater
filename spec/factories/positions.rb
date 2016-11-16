FactoryGirl.define do
  factory :position do
    name "position_name"
    description "position_description"
    association :category, factory: :category
    association :user, factory: :user
  end
end
