require 'spec_helper'

describe "site_configs/edit" do
  before(:each) do
    @site_config = assign(:site_config, stub_model(SiteConfig,
      :domain => "MyString",
      :title => "MyString",
      :author => "MyString",
      :desc => "MyText",
      :weixin_token => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit site_config form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", site_config_path(@site_config), "post" do
      assert_select "input#site_config_domain[name=?]", "site_config[domain]"
      assert_select "input#site_config_title[name=?]", "site_config[title]"
      assert_select "input#site_config_author[name=?]", "site_config[author]"
      assert_select "textarea#site_config_desc[name=?]", "site_config[desc]"
      assert_select "input#site_config_weixin_token[name=?]", "site_config[weixin_token]"
      assert_select "input#site_config_email[name=?]", "site_config[email]"
    end
  end
end
