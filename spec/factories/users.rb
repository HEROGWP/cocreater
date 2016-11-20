FactoryGirl.define do
  factory :user do
  	sequence :email do |n|
    	"test#{n}@gmail.com"
  	end
    password "12345678"
    role "admin"
    fb_uid "1234"
  end
end
