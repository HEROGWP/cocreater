json.(@user, :id, :name, :description)
json.logo_url asset_url( @user.logo.url(:thumb) )
json.categories @user.categories.map(&:name)