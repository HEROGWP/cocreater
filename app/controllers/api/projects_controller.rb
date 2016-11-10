class Api::ProjectsController < Api::BaseController
	before_action :authenticate_user!
	
	def index
		@new_projects = Project.includes(:pictures).new_projcets
		@success_projects = Project.includes(:pictures).success_projcets
	end
end
