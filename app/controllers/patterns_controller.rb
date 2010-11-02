class PatternsController < ApplicationController
  # skip_before_filter :get_site, :only => :preview
  respond_to :svg
  
  def preview
    if @site.private?
      permit('admin') { do_preview }
    else
      do_preview
    end
  end
  
  def do_preview
    @pattern = Pattern.find params[:id]
    render :text => @pattern.view.camelize.constantize.new.render(params[:properties], :height => 300, :width => 300, :offsets => params[:offsets], :preview => true)
  end
end
