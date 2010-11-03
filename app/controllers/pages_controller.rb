class PagesController < ApplicationController
  def about
    @sites = Site.all
  end
  
  def feed
    @designs = @site.designs.approved.recent.limit(10)
  end
end
