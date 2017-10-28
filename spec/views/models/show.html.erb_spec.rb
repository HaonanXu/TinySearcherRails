require 'rails_helper'

RSpec.describe "models/show", type: :view do
  before(:each) do
    @model = assign(:model, Model.create!(
      :User => "User",
      :name => "Name",
      :eamil => "Eamil",
      :password => "Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/User/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Eamil/)
    expect(rendered).to match(/Password/)
  end
end
