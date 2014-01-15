require 'spec_helper'

describe "site_configs/index" do
  before(:each) do
    assign(:site_configs, [
      stub_model(SiteConfig,
        :domain => "Domain",
        :title => "Title",
        :author => "Author",
        :desc => "MyText",
        :weixin_token => "Weixin Token",
        :email => "Email"
      ),
      stub_model(SiteConfig,
        :domain => "Domain",
        :title => "Title",
        :author => "Author",
        :desc => "MyText",
        :weixin_token => "Weixin Token",
        :email => "Email"
      )
    ])
  end

  it "renders a list of site_configs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Weixin Token".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
