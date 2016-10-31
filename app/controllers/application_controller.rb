class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
end
