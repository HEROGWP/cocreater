class Position < ApplicationRecord
	after_initialize :set_default_values
	
	belongs_to :user
	belongs_to :category
	belongs_to :project

	def set_default_values
		user = User.find_by_email('test@gmail.com')
		( self.user_id ||= user.id ) if user
	end
end
