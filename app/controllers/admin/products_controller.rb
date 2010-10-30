class Admin::ProductsController < Admin::BaseController
  inherit_resources
  
  def index
    @products = Product.not_ignored
  end
  
  def sort
    params[:product].each_with_index do |id, index|  
      Product.update_all(["position=?", index+1], ["id=?", id])  
    end  
    render :text => "success"
  end
end
