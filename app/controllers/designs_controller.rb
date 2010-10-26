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

    if @design.valid?
      image = StringIO.new @design.render :height => 600, :width => 600
      def image.original_filename;"3iehdk8hdju-design.svg"; end
      def image.content_type;"image/svg+xml"; end
      @design.image = image
    end

    respond_to do |format|
      if @design.save
        FileUtils.rm "#{Rails.root}/public/system/designs/images/#{@design.id}/original.svg"
        format.html { redirect_to(@design, :notice => 'Design was successfully created.') }
        format.xml  { render :xml => @design, :status => :created, :location => @design }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @design.errors, :status => :unprocessable_entity }
      end
    end
  end
end
