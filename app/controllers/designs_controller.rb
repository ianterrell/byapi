class DesignsController < ApplicationController
  # TODO: use inheritedresource -- set chain properly to @site.designs
  
  respond_to :html, :xml, :json
  
  def recent
    @designs = @site.designs.approved.recent.paginate :page => params[:page]
    respond_with @designs
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

  def edit
    @design = Design.find(params[:id])
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

  def update
    @design = Design.find(params[:id])

    respond_to do |format|
      if @design.update_attributes(params[:design])
        format.html { redirect_to(@design, :notice => 'Design was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @design.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @design = Design.find(params[:id])
    @design.destroy

    respond_to do |format|
      format.html { redirect_to(designs_url) }
      format.xml  { head :ok }
    end
  end
end
