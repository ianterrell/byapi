class PatternsController < ApplicationController
  skip_before_filter :get_site, :only => :preview
  
  respond_to :svg
  
  def preview
    @pattern = Pattern.find params[:id]
    @properties = params[:properties]
  end
end
