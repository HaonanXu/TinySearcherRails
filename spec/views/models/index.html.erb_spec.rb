require 'rails_helper'

RSpec.describe "models/index", type: :view do
  before(:each) do
    assign(:models, [
      Model.create!(
        :User => "User",
        :name => "Name",
        :eamil => "Eamil",
        :password => "Password"
      ),
      Model.create!(
        :User => "User",
        :name => "Name",
        :eamil => "Eamil",
        :password => "Password"
      )
    ])
  end

  it "renders a list of models" do
    render
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Eamil".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
  end
end
