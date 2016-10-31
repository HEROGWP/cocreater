class Admin::CategoriesController < ApplicationController
	before_action :set_categories
	before_action :set_category, :only => [:update, :destroy]
	
	def index
		if params[:id]
			set_category
			set_update_params
		else
			@category = Category.new
			set_create_params
		end			
		set_pagination
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "success to create"
			set_pagination
			redirect_to admin_categories_path
		else
			flash[:alert] = "failed to create"
			set_create_params
			set_pagination
			render :index
		end
	end

	def update
		if @category.update(category_params)
			flash[:notice] = "success to update"
			set_pagination
			redirect_to admin_categories_path
		else
			flash[:alert] = "failed to update"
			set_update_params
			set_pagination
			render :index
		end
	end

	def destroy
		page = set_destory_page(@categories, @category)
		@category.destroy
		flash[:notice] = "success to delete"
		set_pagination
		redirect_to admin_categories_path(:page => page)
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end

	def set_categories
		@categories = Category.order_updated
	end

	def set_pagination
		@categories = @categories.page(params[:page]).per(5)
	end

	def set_category
		@category = Category.find(params[:id])
	end
	
	def set_create_params
		@url = admin_categories_path
		@method = "post"
		@submit_name = "Create"
	end

	def set_update_params
		@url = admin_category_path(@category)
		@method = "patch"
		@submit_name = "Update"
	end

end
