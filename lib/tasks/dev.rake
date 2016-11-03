namespace :dev do
desc "重建一些假資料"
	task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :rebuild => ["dev:build" , :fake]
  task :fake => :environment do
  	User.create(email: "test@gmail.com", password: "12345678", role: "admin", name: "test", phone: "0912345678")
    User.create(email: "pp820819@gmail.com", password: "12345678", role: "admin", name: "pp820819", phone: "0912345678")
    User.create(email: "iamcute@gmail.com", password: "12345678", name: "iamcute", phone: "0912345678")
  	100.times do
    	@category = Category.create(name: Faker::Beer.style)
    	puts "create category id is #{@category.name}"
    end
  end
end
