Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "admin/categories#index"
	
	namespace :admin do
  	resources :categories, only: [:index, :create, :update, :destroy]
  	resources :users, only: [:index, :destroy] do
      member do
  		  post :role_change
      end
  	end
	end

  namespace :api, :defaults => { :format => :json } do
    post "login" => "auth#login"
    post "logout" => "auth#logout"
    
    resources :projects, only: [:index, :show]
    resource :self, only: [:show] do 
      resources :projects, :controller => "self_projects", only: [:show]
    end
  end

  resources :users, only: [:index, :show]
  resources :projects, except: [:new, :edit]
end
