require 'spec_helper'

describe "site_configs/show" do
  before(:each) do
    @site_config = assign(:site_config, stub_model(SiteConfig,
      :domain => "Domain",
      :title => "Title",
      :author => "Author",
      :desc => "MyText",
      :weixin_token => "Weixin Token",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Domain/)
    rendered.should match(/Title/)
    rendered.should match(/Author/)
    rendered.should match(/MyText/)
    rendered.should match(/Weixin Token/)
    rendered.should match(/Email/)
  end
end
