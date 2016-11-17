FactoryGirl.define do
  factory :user do
  	sequence :email do |n|
    	"test#{n}@gmail.com"
  	end
    password "12345678"
    role "user"
    fb_uid "1234"
    factory :admin do
    	role "admin"
    end
  end
end
