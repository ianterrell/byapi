require 'spec_helper'

describe "designs/edit.html.erb" do
  before(:each) do
    @design = assign(:design, stub_model(Design,
      :new_record? => false,
      :site_id => 1
    ))
  end

  it "renders the edit design form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => design_path(@design), :method => "post" do
      assert_select "input#design_site_id", :name => "design[site_id]"
    end
  end
end
