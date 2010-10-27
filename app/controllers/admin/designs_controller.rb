class Admin::DesignsController < Admin::BaseController
  inherit_resources
  belongs_to :site
  
  def unapproved
    @site = Site.find params[:site_id]
    if request.post?
      (params[:designs] || {}).each_pair do |id, approval|
        design = Design.find id
        if approval == "1"
          design.approve!
        else
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
