require 'rails_helper'

RSpec.describe "models/edit", type: :view do
  before(:each) do
    @model = assign(:model, Model.create!(
      :User => "MyString",
      :name => "MyString",
      :eamil => "MyString",
      :password => "MyString"
    ))
  end

  it "renders the edit model form" do
    render

    assert_select "form[action=?][method=?]", model_path(@model), "post" do

      assert_select "input[name=?]", "model[User]"

      assert_select "input[name=?]", "model[name]"

      assert_select "input[name=?]", "model[eamil]"

      assert_select "input[name=?]", "model[password]"
    end
  end
end
