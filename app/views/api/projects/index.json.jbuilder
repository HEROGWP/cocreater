json.new_projects @new_projects do |project|
  json.id project.id
  json.name project.name
  json.school project.school
  json.category project.category

  json.pictures_url project.pictures.map{|picture| asset_url( picture.photo.url(:medium))}
   	
end

json.success_projects @success_projects do |project|
	json.id project.id
  json.name project.name
  json.school project.school
  json.category project.category

  json.pictures_url project.pictures.map{|picture| asset_url( picture.photo.url(:medium)) }
end
