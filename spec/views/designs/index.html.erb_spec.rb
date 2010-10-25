require 'spec_helper'

describe "designs/index.html.erb" do
  before(:each) do
    assign(:designs, [
      stub_model(Design,
        :site_id => 1
      ),
      stub_model(Design,
        :site_id => 1
      )
    ])
  end

  it "renders a list of designs" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
