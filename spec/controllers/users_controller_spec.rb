require 'rails_helper'

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
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "redirects to the search index page" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to redirect_to search_index_path
      end
    end

    context "with invalid params" do
      it " display the 'new' template" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to render_template :new
      end
    end
  end

end
