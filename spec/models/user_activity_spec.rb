require 'rails_helper'

RSpec.describe UserActivity, type: :model do
  let(:valid_params) {
    {"user_id"=>1, "ip"=>"0.0.0.0", "action"=>{event: "LOGIN", status: "SUCCESS"}}
  }

  let(:invalid_params) {
    {"user_id"=>1, "ip"=>"0.0.0.0", "action"=>{event: "LOGIN", status: "SUCCESS"}}
  }

  describe '#action' do
    it "should be present" do
      user_activity = UserActivity.new({:user_id => 1})
      expect(user_activity.valid?).to be_falsey
      expect(user_activity.errors.messages[:action]).to eq ["can't be blank"]
    end
  end
end
