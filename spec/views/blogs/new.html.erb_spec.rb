require 'spec_helper'

describe "blogs/new" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :titile => "MyString",
      :type => "",
      :author => "MyString",
      :link => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new blog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blogs_path, "post" do
      assert_select "input#blog_titile[name=?]", "blog[titile]"
      assert_select "input#blog_type[name=?]", "blog[type]"
      assert_select "input#blog_author[name=?]", "blog[author]"
      assert_select "input#blog_link[name=?]", "blog[link]"
      assert_select "textarea#blog_content[name=?]", "blog[content]"
    end
  end
end
