class Api::SelfProjectsController < Api::BaseController
	before_action :authenticate_user!
	
	def show
		@project = Project.find(params[:id])
	end
end
