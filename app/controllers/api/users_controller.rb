class Api::UsersController < Api::BaseController
	before_action :authenticate_user!
	
	def show
		@user = User.find(params[:id])
	end
end
