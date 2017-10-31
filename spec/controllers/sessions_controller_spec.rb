require 'rails_helper'
require 'factories/users'
require 'factory_bot'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    it "Log in exisiting user with correct password" do
      user = FactoryBot.create(:user)
      post :create, :params => {:email => user.email, :password => user.password}
      expect(response).to redirect_to root_url
      expect(flash[:notice]).to eq("Log In Successfully!")
    end

    it "Should create success login activity in database" do
      user = FactoryBot.create(:user)
      expect {
        post :create, :params => {:email => user.email, :password => user.password}
      }.to change(UserActivity, :count).by(1)

      expect(UserActivity.first).to  have_attributes :user_id => user.id, :action => {"event" => "LOGIN", "status" => "SUCCESS"}
    end

    it "Redirect to login page on failed auth" do
      user = FactoryBot.create(:user)
      post :create, :params => {:email => user.email, :password => user.password + "testtest"}
      expect(response).to redirect_to new_session_path
    end

    it "Should create failed login activity on failed auth" do
      user = FactoryBot.create(:user)
      expect {
        post :create, :params => {:email => user.email, :password => user.password + "testtest"}
      }.to change(UserActivity, :count).by(1)

      expect(flash[:notice]).to eq("Email or Password is invalid")

      expect(UserActivity.first).to  have_attributes :user_id => user.id, :action => {"event" => "LOGIN", "status" => "FAILED"}
    end
  end

  describe "DELETE #destroy" do
    it "should redirect to home page after log out" do
      user = FactoryBot.create(:user)

      request.session[:user_id] = user.id

      delete :destroy, :params => {:id => user.id}

      expect(response).to redirect_to root_path
      expect(flash[:notice]).to eq("Logged Out")
      end

    it "should create success logout activity" do
      user = FactoryBot.create(:user)

      request.session[:user_id] = user.id

      delete :destroy, :params => {:id => user.id}

      expect(UserActivity.first).to have_attributes :user_id => user.id, :action => {"event" => "LOGOUT", "status" => "SUCCESS"}
    end
  end

end
