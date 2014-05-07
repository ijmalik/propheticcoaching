require 'spec_helper'

describe "exercises/index" do
  before(:each) do
    assign(:exercises, [
      stub_model(Exercise,
        :body => "MyText",
        :last_import => false
      ),
      stub_model(Exercise,
        :body => "MyText",
        :last_import => false
      )
    ])
  end

  it "renders a list of exercises" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
