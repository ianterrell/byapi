class DesignsController < ApplicationController
  def recent
    @designs = @site.designs.approved.recent.paginate :page => params[:page]
    render :action => :index
  end
  
  def best_selling
    @designs = @site.designs.approved.best_selling.paginate :page => params[:page]
    render :action => :index
  end

  # TODO:  if we can make sure we've finished our API work first, we can cache :show
  def show
    @design = Design.find(params[:id])
  end

  def new
    @design = Design.new :category => @site.default_category
  end

  def create
    @design = @site.designs.build(params[:design])

    @design.regenerate_pngs if @design.valid?

    respond_to do |format|
      if @design.save
        @design.remove_original_svg!
        format.html { redirect_to(@design, :notice => 'Design was successfully created.') }
        format.xml  { render :xml => @design, :status => :created, :location => @design }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @design.errors, :status => :unprocessable_entity }
      end
    end
  end
end
