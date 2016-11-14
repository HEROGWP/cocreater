json.recruit_projects @recruit_projects do |project|
  json.(project, :id, :name, :description, :startdate, :deadline, :status)
  json.categories project.categories.map(&:name)
  json.pictures_url project.pictures.map{ |picture| asset_url( picture.photo.url(:medium) ) }
   	
end

json.success_projects @success_projects do |project|
	json.(project, :id, :name, :description, :deadline, :status)
  json.pictures_url project.pictures.map{ |picture| asset_url( picture.photo.url(:medium) ) }
end
