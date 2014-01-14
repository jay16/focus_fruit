require 'spec_helper'

describe "folders/edit" do
  before(:each) do
    @folder = assign(:folder, stub_model(Folder,
      :name => "MyString",
      :desc => "MyText"
    ))
  end

  it "renders the edit folder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", folder_path(@folder), "post" do
      assert_select "input#folder_name[name=?]", "folder[name]"
      assert_select "textarea#folder_desc[name=?]", "folder[desc]"
    end
  end
end
