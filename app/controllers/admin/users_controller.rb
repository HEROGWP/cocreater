class Admin::UsersController < Admin::BaseController
	before_action :set_users, only: [:index]
	before_action :set_user, only: [:role_change]

	def index
	end

	def role_change
		params[:role] == "admin" ? @user.update(:role => "admin") : @user.update(:role => "user")
		redirect_to :back
	end

	private

	def set_users
		@users = User.all.page(params[:page]).per(5)
	end

	def set_user
		@user = User.find(params[:id])
	end
	
end
