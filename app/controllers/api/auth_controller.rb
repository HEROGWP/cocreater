class Api::AuthController < Api::BaseController
	before_action :authenticate_user!, :only => [:logout]

	def login
    user = User.find_by_email( params[:email] )
    if user && user.valid_password?( params[:password] )
      render :json => { :status => 200,
      									:message => "Ok",
                        :auth_token => user.authentication_token,
                        :user_id => user.id }
    else
      render :json => { :status => 401, :message => "Email or Password is wrong" }, :status => 401
    end
  end

  def logout
    current_user.generate_authentication_token
    current_user.save!

    render :json => { :status => 200, :message => "Ok"}
  end
end
