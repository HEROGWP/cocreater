class ProjectsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	before_action :set_projects
	before_action :set_project, :only => [:update, :destroy, :show]
	
	def index
		if params[:id]
			set_project
			set_update_params
		else
			@project = current_user.owned_projects.build if current_user
			set_create_params
		end			
		set_pagination
	end

	def show
		@join_users = @project.join_users
	end

	def create
		@project = current_user.owned_projects.build(project_params)
		if @project.save
			@project.create_pictures(params[:photos])
			flash[:notice] = "success to create"
			set_pagination
			redirect_to projects_path
		else
			flash[:alert] = "failed to create"
			set_create_params
			set_pagination
			render :index
		end
	end

	def update
		
		if @project.update(project_params)
			@project.destroy_pictures(params[:photos])
			@project.create_pictures(params[:photos])
			flash[:notice] = "success to update"
			set_pagination
			redirect_to projects_path
		else
			flash[:alert] = "failed to update"
			set_update_params
			set_pagination
			render :index
		end
	end

	def destroy
		page = set_destory_page(@projects, @project)
		@project.destroy
		flash[:notice] = "success to delete"
		set_pagination
		redirect_to projects_path(:page => page)
	end

	private

	def project_params
		params.require(:project).permit(:name, :location, :description, :vision, :story , :status, :category, :startdate, :deadline, :positions_attributes => [:id, :name, :description, :category_id, :_destroy], :category_ids => [])
	end

	def set_projects
		@projects = Project.includes(:pictures).order_updated
	end

	def set_pagination
		@projects = @projects.page(params[:page]).per(5)
	end

	def set_project
		@project = Project.find(params[:id])
	end
	
	def set_create_params
		@url = projects_path
		@method = "post"
		@submit_name = "Create"
	end

	def set_update_params
		@url = project_path(@project)
		@method = "patch"
		@submit_name = "Update"
	end

end
