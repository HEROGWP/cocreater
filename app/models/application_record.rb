class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def create_pictures(photos)
    unless photos.blank?
    	photos.each do |photo|
  			self.pictures.create(:photo => photo)
  		end
    end
  end

  def destroy_pictures(photos)
  	unless photos.blank?
  		self.pictures.destroy_all
  	end
  end

end
