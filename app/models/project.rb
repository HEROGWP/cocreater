class Project < ApplicationRecord
	validates_presence_of :name, :location, :school, :message => "不能是空！！！"

	has_many :pictures, :dependent => :destroy

	scope :order_updated, -> { order('updated_at DESC') }
end
