class Admin::BaseController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin!

	private

	def authenticate_admin!
		unless current_user.admin?
			flash[:alert] = "你目前沒有管理者權限"
			redirect_to projects_path
		end
	end
end
