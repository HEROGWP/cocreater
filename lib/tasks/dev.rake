namespace :dev do
desc "重建一些假資料"
	task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :rebuild => ["dev:build" , :fake]
  task :fake => :environment do
  	
    categories = ["攝影", "插畫", "程式", "雕塑", "建築", "音樂", "設計", "動畫", "科學", "語言"]
    categories.each do |category|
      @category = Category.create(name: category)
      puts "create category name is #{@category.name}"
    end

    User.create(
      email: "test@gmail.com", 
      password: "12345678", 
      role: "admin", name: " 蔡建弘", 
      phone: "0912345678",
      description: "我是蔡建弘，在網路上暱稱是HEROGWP，目前是 ALPHA Camp 網站開發工程師實戰營的學生，並於11月底畢業，11/23歡迎來參加我們的Demo day", 
      category_ids: (1..10).to_a.sample(4), 
      authentication_token:  Devise.friendly_token)
    User.create(email: "pp820819@gmail.com", password: "12345678", role: "admin", name: "pp820819", phone: "0912345678", authentication_token:  Devise.friendly_token)
    User.create(email: "iamcute@gmail.com", password: "12345678", name: "iamcute", phone: "0912345678", authentication_token:  Devise.friendly_token)
  	

  	for user in 1..50 do
      category_ids = (1..10).to_a.sample(rand(1..10))
    	@user = User.create(
    						email: Faker::Internet.email, 
    						password: "12345678", 
    						name: Faker::Name.name, 
    						phone: Faker::PhoneNumber.cell_phone, 
    						description: Faker::Lorem.paragraph,
                category_ids: category_ids,
                authentication_token:  Devise.friendly_token
    					)
    	puts "create user name is #{@user.name}"

      2.times do
        date = Time.at(rand((40.years)..(47.years))).to_date
        category_ids = (1..10).to_a.sample(4)
        status = ["募集中", "進行中", "已完成"].sample
        @project = @user.owned_projects.create(
                  name: Faker::Pokemon.name,
                  location: Faker::Pokemon.location,
                  description: "背包裡是畫筆，手提著畫袋，搭著地鐵去上畫，每張明信片藏著一個小念頭、一份小情緒，但都是一次次有溫度的掙扎，暖暖的每頁，希望你／妳能前來翻找、閱讀，可能的話，幫我實現我的夢，好嗎？",
                  vision: Faker::Lorem.paragraph,
                  story: Faker::Lorem.paragraph,
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
          @position = @project.positions.create(name: "攝影師", description: "幫我攝影", category_id: 1)
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
