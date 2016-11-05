class ProjectCategoryship < ApplicationRecord
	belongs_to :project
	belongs_to :category
end
