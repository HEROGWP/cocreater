module RequestLogin

    def login_user
      @user ||= FactoryGirl.create(:user)
      post user_session_path, params:{ 'user[email]' => @user.email, 'user[password]' => "12345678"}
      follow_redirect!
    end

    def login_admin
      @user ||= FactoryGirl.create(:admin)
      post user_session_path, params:{ 'user[email]' => @user.email, 'user[password]' => "12345678"}
      follow_redirect!
    end

end