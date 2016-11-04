class Project < ApplicationRecord
	validates_presence_of :name, :location, :school, :message => "不能是空！！！"

	scope :order_updated, -> { order('updated_at DESC') }
end
