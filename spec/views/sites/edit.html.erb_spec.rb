require 'spec_helper'

describe "sites/edit.html.erb" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :new_record? => false,
      :domain => "MyString"
    ))
  end

  it "renders the edit site form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => site_path(@site), :method => "post" do
      assert_select "input#site_domain", :name => "site[domain]"
    end
  end
end
