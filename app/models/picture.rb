class Picture < ApplicationRecord
	belongs_to :project

	has_attached_file :photo, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/picture.jpg"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
