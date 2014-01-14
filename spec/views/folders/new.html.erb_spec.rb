require 'spec_helper'

describe "folders/new" do
  before(:each) do
    assign(:folder, stub_model(Folder,
      :name => "MyString",
      :desc => "MyText"
    ).as_new_record)
  end

  it "renders new folder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", folders_path, "post" do
      assert_select "input#folder_name[name=?]", "folder[name]"
      assert_select "textarea#folder_desc[name=?]", "folder[desc]"
    end
  end
end
