require 'spec_helper'

describe "pictures/index" do
  before(:each) do
    assign(:pictures, [
      stub_model(Picture,
        :name => "Name",
        :desc => "MyText",
        :store => "Store",
        :folder_id => 1
      ),
      stub_model(Picture,
        :name => "Name",
        :desc => "MyText",
        :store => "Store",
        :folder_id => 1
      )
    ])
  end

  it "renders a list of pictures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Store".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
