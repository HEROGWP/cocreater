FactoryGirl.define do
  factory :user do
    email "test@gmail.com" 
    password "12345678"
    role "admin"
    fb_uid "1234"
  end
end
