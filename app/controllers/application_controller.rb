class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout

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
end
