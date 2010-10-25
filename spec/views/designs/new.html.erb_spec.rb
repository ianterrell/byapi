require 'spec_helper'

describe "designs/new.html.erb" do
  before(:each) do
    assign(:design, stub_model(Design,
      :site_id => 1
    ).as_new_record)
  end

  it "renders new design form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => designs_path, :method => "post" do
      assert_select "input#design_site_id", :name => "design[site_id]"
    end
  end
end
