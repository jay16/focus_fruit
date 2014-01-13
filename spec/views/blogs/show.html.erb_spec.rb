require 'spec_helper'

describe "blogs/show" do
  before(:each) do
    @blog = assign(:blog, stub_model(Blog,
      :titile => "Titile",
      :type => "Type",
      :author => "Author",
      :link => "Link",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Titile/)
    rendered.should match(/Type/)
    rendered.should match(/Author/)
    rendered.should match(/Link/)
    rendered.should match(/MyText/)
  end
end
