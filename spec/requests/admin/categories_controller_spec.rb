require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :request do
  
  let!(:user) { create(:user, email: "test@gmail.com") }
  let!(:category) { create(:category) }

  describe "login doesn't admin" do
    
    before(:each) { login_user }
    before(:each) { get "/admin/categories" }
    
    it { expect(response).to have_http_status(302) }
    it { expect(response).to redirect_to(projects_path) }
    it { expect(flash[:alert]).to eq("你目前沒有管理者權限") }
    it do 
     
      follow_redirect! 
      expect(response).to be_success
      expect(response.body).to include("你目前沒有管理者權限") 
    
    end
  end

  describe "GET /categories" do
    
    before(:each) { login_admin }
    before(:each) { get "/admin/categories" }

    it { expect(response).to be_success }
    it { expect(response).to have_http_status(200) }
    it { expect(response).to render_template("admin/categories/index") }

  end

  describe "POST /categories" do
    
    before(:each) { login_admin }
    
    context "create category success" do

      before(:each) { post "/admin/categories", params: { category: { name: "art" } } }

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(admin_categories_url) }
      it { expect(flash[:notice]).to eq("success to create") }
      it do 
        
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to create")
        expect(response.body).to include("art")
      
      end

    end

    context "create category failed" do
      
      before(:each) { post "/admin/categories", params: { category: { name: "" } } }
      
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("admin/categories/index") }
      it{ expect(flash[:alert]).to eq("failed to create") }
      it{ expect(response.body).to include("failed to create") }

    end

  end

  describe "PATCH /categories/:id" do
    
    before(:each) { login_admin }
    
    context "update category success" do

      before(:each) { patch "/admin/categories/#{category.id}", params: { category: { name: "art" } } }

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(admin_categories_url) }
      it { expect(flash[:notice]).to eq("success to update") }
      it do 
        
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to update")
        expect(response.body).to include("art")
      
      end

    end

    context "update category failed" do
      
      before(:each) { patch "/admin/categories/#{category.id}", params: { category: { name: "" } } }
      
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("admin/categories/index") }
      it{ expect(flash[:alert]).to eq("failed to update") }
      it{ expect(response.body).to include("failed to update") }

    end

  end

  describe "DELETE category/:id" do
    
    before(:each) { login_admin }
    before(:each) { delete "/admin/categories/#{category.id}" }

    context "destroy category success" do

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to( admin_categories_url( page: assigns(:page) ) ) }
      it { expect(flash[:notice]).to eq("success to delete") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to delete")
      
      end

    end

  end

end