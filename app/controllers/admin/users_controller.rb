class Admin::UsersController < Admin::BaseController
	before_action :set_users, only: [:index, :destroy]
	before_action :set_user, only: [:destroy, :role_change]

	def index
		set_pagination
	end

	def destroy
		page = set_destory_page(@users, @user)
		@user.destroy
		flash[:notice] = "success to delete"
		set_pagination
		redirect_to admin_users_path(:page => page)
	end

	def role_change
		params[:role] == "admin" ? @user.update(:role => "admin") : @user.update(:role => "user")
		redirect_to :back
	end

	private

	def set_users
		@users = User.all.order_role
	end

	def set_user
		@user = User.find(params[:id])
	end
	
	def set_pagination
		@users = @users.page(params[:page]).per(5)
	end
end
