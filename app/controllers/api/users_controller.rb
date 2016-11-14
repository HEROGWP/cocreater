class Api::UsersController < Api::BaseController
	before_action :authenticate_user!
	
	def show
		@user = User.find(params[:id])
	end

	def projects
		@user = User.find(params[:id])
		@recruit_projects = @user.owned_projects.includes(:pictures).recruit_projects
		@success_projects = @user.owned_projects.includes(:pictures).success_projects
	end
end
