class PagesController < ApplicationController
  def about
    @sites = Site.all
  end
end
