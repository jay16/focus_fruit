require 'spec_helper'

describe "shop_carts/index" do
  before(:each) do
    assign(:shop_carts, [
      stub_model(ShopCart,
        :weixin => "Weixin",
        :idstr => "Idstr",
        :session => "MyText"
      ),
      stub_model(ShopCart,
        :weixin => "Weixin",
        :idstr => "Idstr",
        :session => "MyText"
      )
    ])
  end

  it "renders a list of shop_carts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Weixin".to_s, :count => 2
    assert_select "tr>td", :text => "Idstr".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
