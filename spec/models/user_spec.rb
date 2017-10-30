require 'rails_helper'
require 'factories/users'
require 'factory_bot'

RSpec.describe User, type: :model do

  let(:valid_params) {
    {"name"=>"MyName", "email"=>"test@test.com", "password"=>"123", "password_confirmation"=>"123"}
  }

  let(:invalid_params) {
    {"name"=>"MyName", "email"=>"test@test.com", "password"=>"123", "password_confirmation"=>"321"}
  }

  it "fails because of no password" do
    expect(User.new({:name => 'name'}).save).to be_falsey
  end

  it "fails because of password and password_confirmation mismatch" do
    expect(User.new(invalid_params).save).to be_falsey
  end

  it "success create with valid values" do
    expect(User.new(valid_params).save).to be_truthy
  end

  describe '#email' do
    it "should be unique" do
      existing_user = FactoryBot.create(:user)
      user = User.new({:email => existing_user.email})
      expect(user.valid?).to be_falsey
      expect(user.errors.messages[:email]).to eq ["has already been taken"]
    end

    it "should in right format" do
      user = User.new({:email => "email"})
      expect(user.valid?).to be_falsey
      expect(user.errors.messages[:email]).to eq ["is invalid"]
      user.email = "email@email."
      expect(user.valid?).to be_falsey
      expect(user.errors.messages[:email]).to eq ["is invalid"]
    end
    end

  describe '#name' do
    it "should be present" do
      user = User.new({:email => "test@test.com"})
      expect(user.valid?).to be_falsey
      expect(user.errors.messages[:name]).to eq ["can't be blank"]
    end
  end
end
