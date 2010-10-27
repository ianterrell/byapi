class StoresController < ApplicationController
  def images
    @store = Store.find params[:id]
  end
end
