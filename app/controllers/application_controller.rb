class ApplicationController < ActionController::Base
  before_filter :get_site
  
  protect_from_forgery
  
protected
  def get_site
    @site = Site.find_by_domain request.domain
  end
end
