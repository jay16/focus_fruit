require 'spec_helper'

describe "customers/edit" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :idstr => "MyString",
      :name => "MyString",
      :phone => "MyString",
      :addtress => "MyString",
      :text1 => "MyString",
      :text2 => "MyString",
      :text3 => "MyString",
      :text4 => "MyString",
      :text5 => "MyString"
    ))
  end

  it "renders the edit customer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", customer_path(@customer), "post" do
      assert_select "input#customer_idstr[name=?]", "customer[idstr]"
      assert_select "input#customer_name[name=?]", "customer[name]"
      assert_select "input#customer_phone[name=?]", "customer[phone]"
      assert_select "input#customer_addtress[name=?]", "customer[addtress]"
      assert_select "input#customer_text1[name=?]", "customer[text1]"
      assert_select "input#customer_text2[name=?]", "customer[text2]"
      assert_select "input#customer_text3[name=?]", "customer[text3]"
      assert_select "input#customer_text4[name=?]", "customer[text4]"
      assert_select "input#customer_text5[name=?]", "customer[text5]"
    end
  end
end
