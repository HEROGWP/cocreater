class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_destory_page(all, source)
		count = all.find_index(source) + 1
		if all.last == source && ( count % 5 == 1)
			page = count / 5
		elsif (count % 5 ) == 0
			page = count / 5 
		else
			page = count / 5 + 1
		end
	end

	def set_layout
		(user_signed_in? && current_user.admin?) ? "admin" : "application"
	end

	protected

	def configure_permitted_parameters
    [:name, :phone, :school, :fb_id, :line_id, :description, :logo, :category_ids => []].each do |user_params|
    	devise_parameter_sanitizer.permit(:sign_in, keys: [user_params])
    	devise_parameter_sanitizer.permit(:account_update, keys: [user_params])
  	end
  end
end
