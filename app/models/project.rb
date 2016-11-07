class Project < ApplicationRecord
	validates_presence_of :name, :location, :school, :message => "不能是空！！！"

	has_many :pictures, :dependent => :destroy

	has_many :project_categoryships, :dependent => :destroy
  has_many :categories , :through => :project_categoryships

  has_many :user_projectships, :dependent => :destroy
  has_many :users , :through => :user_projectships

  has_many :positions, :dependent => :destroy
  accepts_nested_attributes_for :positions, allow_destroy: true, :reject_if => :all_blank

	scope :order_updated, -> { order('updated_at DESC') }

	belongs_to :owner, :class_name => "User" ,:foreign_key => "user_id"

	def join_users
		self.users.where(user_projectships:{join: true})
	end
end
