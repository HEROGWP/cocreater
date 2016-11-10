require 'rails_helper'

RSpec.describe "Auth", type: :request do

  let!(:user) {  User.create!( :email => "test@gmail.com", :password => "12345678", :fb_uid => "1234" ) }

  describe "login" do
    it "should login successfully" do
       post "/api/login", :email => user.email, :password => "12345678"

       expect(response).to have_http_status(200)

       data = {
         "status" => 200,
         "message" => "Ok",
         "auth_token" => user.authentication_token,
         "user_id" => user.id
       }

       expect(JSON.parse(response.body)).to eq(data)
     end

    it "should login failed if wrong email or password" do
      post "/api/login"

      expect(response).to have_http_status(401)
    end


    it "should login failed if wrong password" do
      post "/api/login", :email => user.email, :password => "xxx"

      expect(response).to have_http_status(401)
    end
  end

  describe "logout" do
    it "should auth error if no auth_token" do
      post "/api/logout"

      expect(response).to have_http_status(401)
    end

    it "should expire user auth token" do
      old_auth_token = user.authentication_token

      post "/api/logout", :auth_token => old_auth_token

      expect(response).to have_http_status(200)

      user.reload
      expect( user.authentication_token ).not_to eq(old_auth_token)
    end

  end
  
end