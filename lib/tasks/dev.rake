namespace :dev do
desc "重建一些假資料"
	task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :rebuild => ["dev:build" , :fake]
  task :fake => :environment do
  	100.times do
    	@category = Category.create(name: Faker::Beer.style)
    	puts "create category id is #{@category.name}"
    end
  end
end
