require 'spec_helper'

describe "sites/index.html.erb" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :domain => "Domain"
      ),
      stub_model(Site,
        :domain => "Domain"
      )
    ])
  end

  it "renders a list of sites" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
  end
end
