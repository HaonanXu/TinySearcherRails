require 'rails_helper'
require 'factories/users'
require 'factory_bot'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) {
    {"name"=>"MyName", "email"=>"test@test.com", "password"=>"123", "password_confirmation"=>"123"}
  }

  let(:invalid_attributes) {
    {"name"=>"MyName", "email"=>"test@test.com", "password"=>"123", "password_confirmation"=>"321"}
  }

  let(:valid_session) { {} }

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "on success" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)

        expect(flash[:notice]).to eq "You have successfully signed up."
      end

      it "generate register activity" do

        post :create, params: {user: valid_attributes}, session: valid_session
        expect(UserActivity.first).to have_attributes :user_id => User.first.id, :action => {"event" => "REGISTER", "status" => "SUCCESS"}
      end

      it "redirects to the search index page" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to redirect_to search_index_path
      end
    end

    context "on failure" do
      it "redirect to register page" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "requires log in" do
      user = FactoryBot.create(:user)

      get :edit, params: {:id => user.id}

      expect(response).to redirect_to root_path
      expect(flash[:notice]).to eq "You must be logged in!"
    end
  end

  describe "PUT #update" do
    context "on success" do
      it "changes user password only" do
        user = FactoryBot.create(:user)
        put :update, params: {:id => user.id, :user => valid_attributes}

        expect(User.find(user.id)).to have_attributes :name => user.name, :email => user.email
      end

      it "generate reset password activity" do
        user = FactoryBot.create(:user)
        put :update, params: {:id => user.id, :user => valid_attributes}

        expect(UserActivity.first).to have_attributes :user_id => user.id, :action => {"event" => "RESET_PASSWORD", "status" => "SUCCESS"}
      end

      it "redirect to search page" do
        user = FactoryBot.create(:user)
        put :update, params: {:id => user.id, :user => valid_attributes}

        expect(response).to redirect_to search_index_path
        expect(flash[:notice]).to eq "Password was successfully changed."
      end
    end

    context "on failure" do
      it "does not change user password" do
        user = FactoryBot.create(:user)

        put :update, params: {:id => user.id, :user => invalid_attributes}

        expect(response).to redirect_to edit_user_path
        expect(flash[:notice]).to eq "Change Password Failed..."
      end

      it "gererates reset password failed activity" do
        user = FactoryBot.create(:user)
        put :update, params: {:id => user.id, :user => invalid_attributes}

        expect(UserActivity.first).to have_attributes :user_id => user.id, :action => {"event" => "RESET_PASSWORD", "status" => "FAILED"}
        expect(flash[:notice]).to eq "Change Password Failed..."
      end
    end
  end
end
