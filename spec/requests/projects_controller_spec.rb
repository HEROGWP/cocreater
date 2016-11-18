require 'rails_helper'

RSpec.describe ProjectsController, type: :request do
	let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }
  let!(:user) { create(:user, email: "test@gmail.com") }
  let!(:project) { create(:project) }

  
  describe "GET /projects" do
  
    subject! { get "/projects" }
    
    it { expect(response).to be_success }
    it { expect(response).to have_http_status(200) }
    it { expect(response).to render_template("projects/index") }
  
  end

  describe "POST /projects" do
    
    before(:each) { login_user }

    context "create project success" do
      
      before(:each) do
        
        data = {
          "project" => {
            "name" => "aaa", 
            "category" => category1.name, 
            "location" => "aaa", 
            "vision" => "aaa", 
            "story" => "aaa", 
            "description" => "aaa", 
            "category_ids" => ["", category1.id, category2.id], 
            "status"=>"已完成", 
            "startdate(1i)"=>"2016", 
            "startdate(2i)"=>"11", 
            "startdate(3i)"=>"17", 
            "deadline(1i)"=>"2016", 
            "deadline(2i)"=>"11", 
            "deadline(3i)"=>"17", 
            "positions_attributes" => { 
              "0" => { 
                "name" => "aaa", 
                "description" => "aaaa", 
                "category_id" => category2.id
              }
            }
          }
        }
        
        post "/projects", params: data 
      
      end
      
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(projects_url) }
      it { expect(flash[:notice]).to eq("success to create") }
      it do 
        
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to create")
      
      end

    end

    context "create project failed" do
      
      before(:each) { post "/projects", params: { "project" => { "vision" => "aaa" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("projects/index") }
      it{ expect(flash[:alert]).to eq("failed to create") }
      it{ expect(response.body).to include("failed to create") }
    
    end
  
  end

  describe "PATCH project/:id" do
  
    before(:each) { login_user }

    context "update project success" do
      
      before(:each) do
        
        data = {
          "project" => {
            "name" => "aaa", 
            "category" => category1.name, 
            "location" => "aaa", 
            "vision" => "aaa", 
            "story" => "aaa", 
            "description" => "aaa", 
            "category_ids" => ["", category1.id, category2.id], 
            "status"=>"已完成", 
            "startdate(1i)"=>"2016", 
            "startdate(2i)"=>"11", 
            "startdate(3i)"=>"17", 
            "deadline(1i)"=>"2016", 
            "deadline(2i)"=>"11", 
            "deadline(3i)"=>"17", 
            "positions_attributes" => { 
              "0" => { 
                "name" => "aaa", 
                "description" => "aaaa", 
                "category_id" => category2.id
              }
            }
          }
        }
        
        patch "/projects/#{project.id}", params: data 
      
      end

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(projects_url) }
      it { expect(flash[:notice]).to eq("success to update") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to update")
      
      end
    
    end

    context "update project failed" do
      
      before(:each) { patch "/projects/#{project.id}", params: { "project" => { "name" => "", "vision" => "aaa" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("projects/index") }
      it{ expect(flash[:alert]).to eq("failed to update") }
      it{ expect(response.body).to include("failed to update") }
    
    end
  
  end

  describe "DELETE project/:id" do
    
    before(:each) { login_user }
    before(:each) { delete "/projects/#{project.id}" }

    context "destroy project success" do

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to( projects_url( page: assigns(:page) ) ) }
      it { expect(flash[:notice]).to eq("success to delete") }
      it do 
      
        follow_redirect! 
        expect(response).to be_success
        expect(response.body).to include("success to delete")
      
      end

    end

  end

  describe "GET project/:id" do
    
    before(:each) { login_user }
    before(:each) { get "/projects/#{project.id}" }

    context "show project success" do
    
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("projects/show") }
      it{ expect(response.body).to include("#{project.name}") }

    end 

  end

end
