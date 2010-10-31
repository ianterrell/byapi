class PagesController < ApplicationController
  def about
    @sites = Site.all
  end
  
  def feed
    @designs = Design.approved.recent.limit(10)
  end
end
