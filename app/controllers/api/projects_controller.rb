class Api::ProjectsController < Api::BaseController
	before_action :authenticate_user!
	
	def index
		@recruit_projects = Project.includes(:pictures, :categories).recruit_projects
		@success_projects = Project.includes(:pictures, :categories).success_projects
	end
end
