class Admin::DesignsController < Admin::BaseController
  inherit_resources
  belongs_to :site
  
  def unapproved
    @site = Site.find params[:site_id]
    approved_count = 0
    rejected_count = 0
    if request.post?
      (params[:designs] || {}).each_pair do |id, values|
        design = Design.find id
        if values[:approval] == "1"
          approved_count += 1
          design.tag_list = values[:tag_list]
          design.category_id = values[:category_id]
          design.save
          design.approve!
        elsif values[:approval] == "0"
          rejected_count += 1
          design.destroy
        end
      end  
      flash[:notice] = "Approved #{approved_count} design#{'s' unless approved_count == 1}, rejected #{rejected_count}."
      redirect_to unapproved_admin_site_designs_path(@site)
    else
      @designs = @site.designs.unapproved
    end
  end
end
