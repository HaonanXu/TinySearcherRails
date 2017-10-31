require 'rails_helper'

RSpec.describe UserActivitiesControllerController, type: :controller do

  describe "GET #show" do
    it "redirect to root path if not logged in" do
      get :show
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to eq "You must be logged in!"
    end
  end

end
