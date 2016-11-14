json.(@project, :id, :name, :vision, :story, :description, :startdate, :deadline, :location)
json.pictures_url @project.pictures.map{ |picture| asset_url( picture.photo.url(:medium) ) }

json.positions @project.positions do |position|
	json.(position, :name, :description)
	json.category position.category.name
	json.logo_url asset_url( position.user.logo.url(:thumb) )
	json.users position.category.users do |user|
		json.id user.id
		json.name user.name
		json.logo_url asset_url( user.logo.url(:thumb) )
	end
end