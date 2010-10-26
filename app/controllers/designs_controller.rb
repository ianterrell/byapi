class DesignsController < ApplicationController
  # TODO: use inheritedresource -- set chain properly to @site.designs
  
  respond_to :html
  
  def recent
    @designs = @site.designs.approved.recent.paginate :page => params[:page]
    render :action => :index
  end
  
  def best_selling
    @designs = @site.designs.approved.best_selling.paginate :page => params[:page]
    respond_with @designs
  end

  def show
    @design = Design.find(params[:id])
    respond_with @design
  end

  def new
    @design = Design.new
    respond_with @design
  end

  def create
    @design = @site.designs.build(params[:design])

    respond_to do |format|
      if @design.save
        format.html { redirect_to(@design, :notice => 'Design was successfully created.') }
        format.xml  { render :xml => @design, :status => :created, :location => @design }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @design.errors, :status => :unprocessable_entity }
      end
    end
  end
end
