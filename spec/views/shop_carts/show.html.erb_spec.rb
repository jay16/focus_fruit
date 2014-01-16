require 'spec_helper'

describe "shop_carts/show" do
  before(:each) do
    @shop_cart = assign(:shop_cart, stub_model(ShopCart,
      :weixin => "Weixin",
      :idstr => "Idstr",
      :session => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Weixin/)
    rendered.should match(/Idstr/)
    rendered.should match(/MyText/)
  end
end
