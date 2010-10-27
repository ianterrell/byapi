class Admin::DesignsController < Admin::BaseController
  inherit_resources
  belongs_to :site
  
  def unapproved
    @site = Site.find params[:site_id]
    if request.post?
      (params[:designs] || {}).each_pair do |id, values|
        design = Design.find id
        if values[:approval] == "1"
          design.tag_list = values[:tag_list]
          design.category_id = values[:category_id]
          design.save
          design.approve!
        elsif values[:approval] == "0"
          design.destroy
        end
      end  
      flash[:notice] = "Did stuff!"
      redirect_to unapproved_admin_site_designs_path(@site)
    else
      @designs = @site.designs.unapproved
    end
  end
end
