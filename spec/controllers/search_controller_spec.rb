require 'rails_helper'
require 'factories/users'
require 'factory_bot'

RSpec.describe SearchController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      allow_any_instance_of(Searcher).to receive(:search).and_return([an_instance_of(Twitter::Tweet)])

      get :show, :params => {:site => "TWITTER", :key_words => "TEST"}

      expect(response).to have_http_status(:success)
    end

    context "when there is a logged in user" do
      it "generate search activity for the user" do
        user = FactoryBot.create(:user)
        request.session[:user_id] = user.id

        allow_any_instance_of(Searcher).to receive(:search).and_return([an_instance_of(Twitter::Tweet)])

        get :show, :params => {:site => "TWITTER", :key_words => "TEST"}

        expect(UserActivity.first).to have_attributes :user_id => user.id, :action => {"event" => "SEARCH", "status" => "SUCCESS"}
      end
    end

    context "when there is no logged in user" do
      it "will not generate activity" do
        allow_any_instance_of(Searcher).to receive(:search).and_return([an_instance_of(Twitter::Tweet)])

        get :show, :params => {:site => "TWITTER", :key_words => "TEST"}

        expect(UserActivity.count).to eq 0
      end
    end

    context "on failure of no key words" do
      it "redirect to search page" do
        get :show, :params => {:site => "TWITTER", :key_words => nil}

        expect(response).to redirect_to search_index_path
        expect(flash[:notice]).to eq "Please type in some keywords..."
      end

      it "generates search activity when a user logged in" do
        user = FactoryBot.create(:user)
        request.session[:user_id] = user.id

        get :show, :params => {:site => "TWITTER", :key_words => nil}

        expect(UserActivity.first).to have_attributes :user_id => user.id, :action => {"event" => "SEARCH", "status" => "FAILED"}
      end
    end

    context "on failure of error" do
      it "redirects to search page" do
        allow_any_instance_of(Searcher).to receive(:search).and_throw([an_instance_of(Twitter::Tweet)])

        get :show, :params => {:site => "TWITTER", :key_words => "TEST"}

        expect(response).to redirect_to search_index_path
      end

      it "generates search fail activity when an user logged in" do
        user = FactoryBot.create(:user)
        request.session[:user_id] = user.id
        allow_any_instance_of(Searcher).to receive(:search).and_throw([an_instance_of(Twitter::Tweet)])

        get :show, :params => {:site => "TWITTER", :key_words => "TEST"}

        expect(UserActivity.first).to have_attributes :user_id => user.id, :action => {"event" => "SEARCH", "status" => "FAILED"}
      end

      it "generates system log record" do
        allow_any_instance_of(Searcher).to receive(:search).and_raise(Twitter::Error.new("twitter error"))

        get :show, :params => {:site => "TWITTER", :key_words => "TEST"}

        expect(SystemLog.first).to have_attributes :event => "Twitter::Error", :message => "twitter error"
        expect(flash[:notice]).to eq "twitter error"
      end
    end
  end

  describe "GET #show_random" do

  end
end
