require 'spec_helper'

describe "ebooks/index" do
  before(:each) do
    assign(:ebooks, [
      stub_model(Ebook,
        :name => "Name"
      ),
      stub_model(Ebook,
        :name => "Name"
      )
    ])
  end

  it "renders a list of ebooks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
