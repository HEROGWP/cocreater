class Api::ProjectsController < Api::BaseController
	def index
		@new_projects = Project.includes(:pictures).new_projcets
		@success_projects = Project.includes(:pictures).success_projcets
	end
end
