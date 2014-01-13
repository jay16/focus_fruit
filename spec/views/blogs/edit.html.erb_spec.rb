require 'spec_helper'

describe "blogs/edit" do
  before(:each) do
    @blog = assign(:blog, stub_model(Blog,
      :titile => "MyString",
      :type => "",
      :author => "MyString",
      :link => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit blog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blog_path(@blog), "post" do
      assert_select "input#blog_titile[name=?]", "blog[titile]"
      assert_select "input#blog_type[name=?]", "blog[type]"
      assert_select "input#blog_author[name=?]", "blog[author]"
      assert_select "input#blog_link[name=?]", "blog[link]"
      assert_select "textarea#blog_content[name=?]", "blog[content]"
    end
  end
end
