require 'spec_helper'

describe "customers/show" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :idstr => "Idstr",
      :name => "Name",
      :phone => "Phone",
      :addtress => "Addtress",
      :text1 => "Text1",
      :text2 => "Text2",
      :text3 => "Text3",
      :text4 => "Text4",
      :text5 => "Text5"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Idstr/)
    rendered.should match(/Name/)
    rendered.should match(/Phone/)
    rendered.should match(/Addtress/)
    rendered.should match(/Text1/)
    rendered.should match(/Text2/)
    rendered.should match(/Text3/)
    rendered.should match(/Text4/)
    rendered.should match(/Text5/)
  end
end
