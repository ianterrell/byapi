class DesignsController < ApplicationController
  # TODO: use inheritedresource -- set chain properly to @site.designs
  
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
    @design = Design.new
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
