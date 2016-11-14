json.(@project, :id, :name, :vision, :story, :description, :startdate, :deadline, :location)
json.pictures_url @project.pictures.map{ |picture| asset_url( picture.photo.url(:medium) ) }
json.owner do
	json.id @owner.id
	json.name @owner.name
	json.category "發起者"
	json.logo_url asset_url( @owner.logo.url(:thumb) )
end
json.positions @project.positions do |position|
	json.(position, :name, :description, :category)
	json.logo_url asset_url( position.user.logo.url(:thumb) )
end