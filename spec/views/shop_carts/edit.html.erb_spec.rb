require 'spec_helper'

describe "shop_carts/edit" do
  before(:each) do
    @shop_cart = assign(:shop_cart, stub_model(ShopCart,
      :weixin => "MyString",
      :idstr => "MyString",
      :session => "MyText"
    ))
  end

  it "renders the edit shop_cart form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shop_cart_path(@shop_cart), "post" do
      assert_select "input#shop_cart_weixin[name=?]", "shop_cart[weixin]"
      assert_select "input#shop_cart_idstr[name=?]", "shop_cart[idstr]"
      assert_select "textarea#shop_cart_session[name=?]", "shop_cart[session]"
    end
  end
end
