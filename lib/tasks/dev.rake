namespace :dev do
desc "重建一些假資料"
	task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :rebuild => ["dev:build" , :fake]
  task :fake => :environment do
  	User.create(email: "test@gmail.com", password: "12345678", role: "admin", name: "test", phone: "0912345678", school: "alpha camp", authentication_token:  Devise.friendly_token)
    User.create(email: "pp820819@gmail.com", password: "12345678", role: "admin", name: "pp820819", phone: "0912345678", school: "alpha camp", authentication_token:  Devise.friendly_token)
    User.create(email: "iamcute@gmail.com", password: "12345678", name: "iamcute", phone: "0912345678", school: "alpha camp", authentication_token:  Devise.friendly_token)
  	
    10.times do
      @category = Category.create(name: Faker::Beer.style)
      puts "create category name is #{@category.name}"
    end

    @categories = Category.all.pluck(:name)

  	for user in 1..50 do
      category_ids = (1..10).to_a.sample(rand(1..10))
    	@user = User.create(
    						email: Faker::Internet.email, 
    						password: "12345678", 
    						name: Faker::Name.name, 
    						phone: Faker::PhoneNumber.cell_phone, 
    						school: Faker::Educator.university, 
    						description: Faker::Lorem.paragraph,
                category_ids: category_ids,
                authentication_token:  Devise.friendly_token
    					)
    	puts "create user name is #{@user.name}"

      2.times do
        date = Time.at(rand((40.years)..(47.years))).to_date
        category_ids = (1..10).to_a.sample(rand(1..10))
        status = ["募集中", "進行中", "已完成"].sample
        @project = @user.owned_projects.create(
                  name: Faker::Pokemon.name,
                  location: Faker::Pokemon.location,
                  school: Faker::Educator.university,
                  description: Faker::Lorem.paragraph,
                  startdate: date,
                  deadline: date + 1.month,
                  status: status, 
                  category_ids: category_ids,
                  user_ids: [1]
                 )
        @project.user_projectships.each do |ship|
          ship.update(join: true)
        end
        2.times do
          @position = @project.positions.create(name: "攝影師", description: "幫我攝影", category: @categories.sample)
        end
        puts "create project name is #{@project.name}"
      end

    end
  end
  task :update_users_token => :environment do
    users = User.all
    users.each do |user| 
      user.update!( authentication_token:  Devise.friendly_token ) 
      puts user.email
    end
  end
end
