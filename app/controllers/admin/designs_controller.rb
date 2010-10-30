class Admin::DesignsController < Admin::BaseController
  inherit_resources
  belongs_to :site
  
  def unapproved
    @site = Site.find params[:site_id]
    approved_count, ignored_count, rejected_count = 0, 0, 0
    if request.post?
      (params[:designs] || {}).each_pair do |id, values|
        design = Design.find id
        if values[:action] == "reject"
          rejected_count += 1
          design.reject!
        else
          design.tag_list = values[:tag_list]
          design.category_id = values[:category_id]
          design.save
          if values[:action] == "ignore"
            ignored_count += 1
            design.ignore!
          elsif values[:action] == "approve"
            approved_count += 1
            design.approve!
          end
        end
      end  
      flash[:notice] = "Approved #{approved_count} design#{'s' unless approved_count == 1}, rejected #{rejected_count}, ignored #{ignored_count}."
      redirect_to unapproved_admin_site_designs_path(@site)
    else
      @designs = @site.designs.unapproved
    end
  end
end
