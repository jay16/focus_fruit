require 'spec_helper'

describe "shop_carts/new" do
  before(:each) do
    assign(:shop_cart, stub_model(ShopCart,
      :weixin => "MyString",
      :idstr => "MyString",
      :session => "MyText"
    ).as_new_record)
  end

  it "renders new shop_cart form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shop_carts_path, "post" do
      assert_select "input#shop_cart_weixin[name=?]", "shop_cart[weixin]"
      assert_select "input#shop_cart_idstr[name=?]", "shop_cart[idstr]"
      assert_select "textarea#shop_cart_session[name=?]", "shop_cart[session]"
    end
  end
end
