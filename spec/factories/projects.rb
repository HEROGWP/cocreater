FactoryGirl.define do
  factory :project do
    name "project_name"
    location "project_location"
    description "project_description"
    vision "project_vision"
    story "project_stroy"
    startdate "2016-11-14"
    deadline "2016-12-14"
    status "募集中" 

    association :owner, factory: :user

  end
end
