class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :user_categoryships, :dependent => :destroy
  has_many :categories , :through => :user_categoryships

  has_many :user_projectships, :dependent => :destroy
  has_many :projects , :through => :user_projectships

  has_many :positions, :dependent => :destroy
  has_many :owned_projects, :class_name => "Project"

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/user.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

	scope :order_role, -> { order('role') }

	before_create :generate_authentication_token

	def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def admin?
  	self.role == "admin"
  end

  #定義給controller 的 method
  def self.from_omniauth(auth)
		# Case 1: Find existing user by facebook uid
		user = User.find_by_fb_uid( auth.uid )
		if user
		  user.fb_token = auth.credentials.token
		  #user.fb_raw_data = auth
		  user.save!
		  return user
		end

		# Case 2: Find existing user by email
		existing_user = User.find_by_email( auth.info.email )
		if existing_user
		 existing_user.fb_uid = auth.uid
		 existing_user.fb_token = auth.credentials.token
		 #existing_user.fb_raw_data = auth
		 existing_user.save!
		 return existing_user
		end

		# Case 3: Create new password
		user = User.new
		user.fb_uid = auth.uid
		user.fb_token = auth.credentials.token
		user.email = auth.info.email
		user.password = Devise.friendly_token[0,20]
		#user.fb_raw_data = auth
		user.save!
		return user
  end
end
