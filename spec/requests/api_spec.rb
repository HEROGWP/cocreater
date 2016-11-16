require 'rails_helper'

RSpec.describe "API", type: :request do
	
	let!(:user) { create(:user, email: "test@gamil.com") }
	let!(:category1) { create(:category) }
	let!(:category2) { create(:category) }
	let!(:category3) { create(:category) }
	let!(:project_recruit) { create(:project, :positions => [ build(:position, category: category1, user: user) ])}
	let!(:project_ing) { create(:project, status: "進行中") }
	let!(:project_success) { create(:project, status: "已完成") }
	before do
	
		create(:project_categoryship, project: project_recruit, category: category1)
		create(:project_categoryship, project: project_recruit, category: category2)
		create(:project_categoryship, project: project_ing, category: category2)
		create(:project_categoryship, project: project_ing, category: category3)
		create(:project_categoryship, project: project_success, category: category1)
		create(:project_categoryship, project: project_success, category: category3)
		create(:user_categoryship, user: user, category: category1)
	
	end

	describe "API projects list" do
		
		it "test projects list response success" do
  
      get "/api/projects", params:{ :auth_token => user.authentication_token }

      recruit_projects = {
      	"recruit_projects" => 
      	Project.recruit_projects.map do |project|
					{
						"id" => project.id,
						"name" => project.name,
						"description" => project.description,
						"startdate" => project.startdate.to_s,
						"deadline" => project.deadline.to_s,
						"status" => "募集中",
						"categories" => project.categories.map(&:name),
						"pictures_url" => []
					}
				end
			}

			success_projects = {
				"success_projects" => 
				Project.success_projects.map do |project|
					{
						"id" => project.id,
						"name" => project.name,
						"description" => project.description,
						"deadline" => project.deadline.to_s,
						"status" => project.status,
						"pictures_url" => []
					}
				end
      }
      data = recruit_projects.merge(success_projects)
      expect(response).to have_http_status(200)	
      expect(JSON.parse(response.body)).to eq(data)

		end
	
	end

	describe "API project" do
		
		it "test project response success" do
  
      get "/api/projects/#{project_recruit.id}", params:{ :auth_token => user.authentication_token }
  
      owner = project_recruit.owner
      data = {
				"id" => project_recruit.id,
				"name" => project_recruit.name,
				"vision" => project_recruit.vision,
				"story" => project_recruit.story,
				"description" => project_recruit.description,
				"startdate" => project_recruit.startdate.to_s,
				"deadline" => project_recruit.deadline.to_s,
				"location" => project_recruit.location,
				"pictures_url" => [],
				"owner" => {
					"id" => owner.id,
					"name" => owner.name,
					"category" => "發起者",
					"logo_url" => request.protocol + request.host_with_port + owner.logo.url(:thumb)
				},
				"positions" =>
					project_recruit.positions.map do |position|
						{
							"name" => position.name,
							"description" => position.description,
							"category" => position.category.name,
							"logo_url" => request.protocol + request.host_with_port + position.user.logo.url(:thumb)
					  }
					end
			}

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(data)	
	
		end
	
	end

	describe "API self project" do
		
		it "test watch self project response success" do
  
      get "/api/self/projects/#{project_recruit.id}", params:{ :auth_token => user.authentication_token }
  
      data = {
      	"id" => project_recruit.id,
				"name" => project_recruit.name,
				"vision" => project_recruit.vision,
				"story" => project_recruit.story,
				"description" => project_recruit.description,
				"startdate" => project_recruit.startdate.to_s,
				"deadline" => project_recruit.deadline.to_s,
				"location" => project_recruit.location,
				"pictures_url" => [],
				"positions" => 
				project_recruit.positions.map do |position|
					{
						"name" => project_recruit.positions.first.name,
						"description" => project_recruit.positions.first.description,
						"category" => project_recruit.positions.first.category.name,
						"logo_url" => request.protocol + request.host_with_port + project_recruit.positions.first.user.logo.url(:thumb),
						"users" => 
						position.category.users.map do |user|
							{
								"id" => user.id,
								"name" => user.name,
								"logo_url" => request.protocol + request.host_with_port + user.logo.url(:thumb)
							}
						end
					}
				end
      }

      expect(response).to have_http_status(200)	
      expect(JSON.parse(response.body)).to eq(data)	

		end
	
	end

	describe "API other user" do
		
		it "test other user response success" do
  
      get "/api/users/#{user.id}", params:{ :auth_token => user.authentication_token }

      data = {
				"id" => user.id,
				"name" => user.name,
				"description" => user.description,
				"logo_url" => request.protocol + request.host_with_port + user.logo.url(:thumb),
				"categories" => user.categories.map(&:name)
			}

      expect(response).to have_http_status(200)	
      expect(JSON.parse(response.body)).to eq(data)	

		end
	
	end

	describe "API user projects" do
		
		it "test user projects response success" do
  
      get "/api/users/#{user.id}/projects", params:{ :auth_token => user.authentication_token }

      recruit_projects = {
      	"recruit_projects" => 
      	user.projects.recruit_projects.map do |project|
					{
						"id" => project.id,
						"name" => project.name,
						"description" => project.description,
						"startdate" => project.startdate.to_s,
						"deadline" => project.deadline.to_s,
						"status" => "募集中",
						"categories" => project.categories.map(&:name),
						"pictures_url" => []
					}
				end
			}
	
			success_projects = {
				"success_projects" => 
				user.projects.success_projects.map do |project|
					{
						"id" => project.id,
						"name" => project.name,
						"description" => project.description,
						"deadline" => project.deadline.to_s,
						"status" => project.status,
						"pictures_url" => []
					}
				end
      }
  
      data = recruit_projects.merge(success_projects)

      expect(response).to have_http_status(200)	
      expect(JSON.parse(response.body)).to eq(data)	

		end
	
	end



end