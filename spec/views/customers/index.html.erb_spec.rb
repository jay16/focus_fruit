require 'spec_helper'

describe "customers/index" do
  before(:each) do
    assign(:customers, [
      stub_model(Customer,
        :idstr => "Idstr",
        :name => "Name",
        :phone => "Phone",
        :addtress => "Addtress",
        :text1 => "Text1",
        :text2 => "Text2",
        :text3 => "Text3",
        :text4 => "Text4",
        :text5 => "Text5"
      ),
      stub_model(Customer,
        :idstr => "Idstr",
        :name => "Name",
        :phone => "Phone",
        :addtress => "Addtress",
        :text1 => "Text1",
        :text2 => "Text2",
        :text3 => "Text3",
        :text4 => "Text4",
        :text5 => "Text5"
      )
    ])
  end

  it "renders a list of customers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Idstr".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Addtress".to_s, :count => 2
    assert_select "tr>td", :text => "Text1".to_s, :count => 2
    assert_select "tr>td", :text => "Text2".to_s, :count => 2
    assert_select "tr>td", :text => "Text3".to_s, :count => 2
    assert_select "tr>td", :text => "Text4".to_s, :count => 2
    assert_select "tr>td", :text => "Text5".to_s, :count => 2
  end
end
