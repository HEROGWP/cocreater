class Api::BaseController < ApplicationController

	skip_before_action :verify_authenticity_token
	before_action :authenticate_user_from_token!

  def authenticate_user_from_token!

    if params[:auth_token].present?
      user = User.find_by(authentication_token: params[:auth_token] )

      # Devise: 設定 current_user
      sign_in(user, store: false) if user
    end

  end

end
