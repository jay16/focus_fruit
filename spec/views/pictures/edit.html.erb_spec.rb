require 'spec_helper'

describe "pictures/edit" do
  before(:each) do
    @picture = assign(:picture, stub_model(Picture,
      :name => "MyString",
      :desc => "MyText",
      :store => "MyString",
      :folder_id => 1
    ))
  end

  it "renders the edit picture form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", picture_path(@picture), "post" do
      assert_select "input#picture_name[name=?]", "picture[name]"
      assert_select "textarea#picture_desc[name=?]", "picture[desc]"
      assert_select "input#picture_store[name=?]", "picture[store]"
      assert_select "input#picture_folder_id[name=?]", "picture[folder_id]"
    end
  end
end
