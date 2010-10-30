require 'net/http'
require 'net/http/post/multipart'
require 'builder'
require 'uri'

module Cafepress
  class Client
    attr_accessor :app_key, :user_token

    def initialize(app_key=CAFEPRESS[:app_key], email=CAFEPRESS[:email], password=CAFEPRESS[:password])
      @app_key, @email, @password = app_key, email, password
    end
    
    def connect!
      response = post_form('authentication.getUserToken.cp', default_options.merge('email' => @email, 'password' => @password))
      if response.is_a?(Net::HTTPOK) && response.body =~ /<value>([0-9\-a-f]+)<\/value>/
        @user_token = $1
        self
      else
        raise 'could not connect to cafepress'
      end
    end
    
    def save_design(design, options={})
      xml = blank_design_xml design
      svg = design.render options.merge(:height => 3000, :width => 3000)
      response = post_form('design.save.cp', default_options.merge({"value" => xml, "svg" => svg}))
      response.is_a?(Net::HTTPOK) ? Design.parse(response.body) : false
    end
    
    def move_and_tag_design(design, folder, tags, category)
      design_ids = design.cafepress_id
      design_ids += ",#{design.cafepress_dark_id}" if design.cafepress_dark_id
      response = post_form('design.moveAndTagDesigns.cp', default_options.merge("designIds" => design_ids, "folderName" => folder, "tags" => tags, "category" => category))
      response.is_a?(Net::HTTPOK)
    end
    
    def create_section_for_design(design)
      xml = section_xml design
      response = post_form('store.saveStoreSection.cp', default_options.merge("value" => xml))
      response.is_a?(Net::HTTPOK) ? StoreSection.parse(response.body) : false
    end
    
    def create_products_for_design(design)
      xml = products_xml(design)
      response = post_form('product.saveAll.cp', default_options.merge("values" => xml))
      if response.is_a? Net::HTTPOK
        merchandises = {}
        ::Product.all.each do |p|
          merchandises[p.cafepress_id] = p
        end
        Products.parse(response.body).products.each do |p|
          design.cafepress_products.create :product => merchandises[p.merchandise_id], :cafepress_id => p.id
        end
        true
      else
        puts response.body
        false
      end
    end
    
    class Value
      include HappyMapper
      tag 'value'
    end
    
    class Design
      include HappyMapper
      tag 'design'
      attribute :id, String
      attribute :media_url, String, :tag => "mediaUrl"
    end
    
    class StoreSection
      include HappyMapper
      tag 'storeSection'
      attribute :id, String
    end
    
    class MediaRegion
      include HappyMapper
      tag "mediaRegion"
      attribute :name, String
      attribute :default_alignment, String, :tag => "defaultAlignment"
    end

    class Merchandise
      include HappyMapper
      tag "merchandise"
      attribute :id, String
      attribute :name, String
      attribute :marketplace_price, String, :tag => "marketplacePrice"
      has_many :media_regions, MediaRegion
    end

    class MerchandiseCollection
      include HappyMapper
      tag "merchandiseCollection"
      has_many :merchandise, Merchandise
    end
    
    class Product
      include HappyMapper
      tag "product"
      attribute :id, String
      attribute :merchandise_id, String, :tag => "merchandiseId"
    end
    
    class Products
      include HappyMapper
      tag "products"
      has_many :products, Product
    end
    
    ###
    ## Just for testing really
    #
    
    def find_design(design)
      response = post_form('design.find.cp', default_options.merge("id" => design.cafepress_id))
      puts response.body
    end
    
    def find_store(store)
      response = post_form('store.findByStoreId.cp', default_options.merge("storeId" => store.name))
      puts response.body
    end
    
    def find_section(store, section_id)
      response = post_form('store.findByStoreSectionId.cp', default_options.merge("storeId" => store.name, "storeSectionId" => section_id))
      puts response.body
    end
    
    def find_product(cafepress_product)
      response = post_form('product.find.cp', default_options.merge("id" => cafepress_product.cafepress_id))
      puts response.body
    end
    
    def list_merchandise
      response = post_form('merchandise.list.cp', "appKey" => @app_key)
      collection = MerchandiseCollection.parse(response.body)
      z = collection.merchandise.map{|m|m.name}
      z.each do |i|
        puts i
      end
    end
    
    def create_products
      ::Product.destroy_all
      response = post_form('merchandise.list.cp', "appKey" => @app_key)
      collection = MerchandiseCollection.parse(response.body)
      collection.merchandise.each do |m|
        p = ::Product.new :name => m.name, :cafepress_id => m.id
        p.media_regions = m.media_regions.map{|mr|"#{mr.name}(#{mr.default_alignment})"}.join(",")
        
        default = m.media_regions.select{|mr|mr.name == "FrontCenter"}.first
        # default = m.media_regions.select{|mr|mr.name == "FrontPocket"}.first
        default = m.media_regions.last unless default
        
        p.default_region = default.name
        p.default_alignment = default.default_alignment
        
        p.marketplace_price = m.marketplace_price
        
        p.dark = !!(m.name =~ /dark/i)
        
        p.section = looks_like_apparel?(m.name) ? "apparel" : "other"
        
        p.save
      end
    end
    
    def looks_like_apparel?(name)
      [/shirt/i, /shorts/i, /jersey/i, /bodysuit/i, /tank/i, /raglan/i, /ringer/i, /hoodie/i, /tracksuit/i, /jacket/i, /brief/i, /thong/i].each do |regex|
        return true if name =~ regex
      end
      false
    end
    
  protected
    def post_form(method, options)
      Net::HTTP.post_form url_for_method(method), options
    end
    
    def url_for_method(method)
      URI.parse("#{CAFEPRESS[:base_url]}/#{method}")
    end
  
    def default_options
      options = {'appKey' => @app_key}
      options['userToken'] = @user_token if @user_token
      options
    end
    
    def blank_design_xml(design)
      xml = ""
      builder = Builder::XmlMarkup.new :target => xml
      builder.design :caption => "#{design.id}: #{design.title}"
      xml
    end
    
    def section_xml(design, options={})
      store = options.delete(:store) || design.store.name
      parent = options.delete(:parent) || "0"
      caption = options.delete(:caption) || design.title
      image = options.delete(:image) || design.cafepress_id
      xml = ""
      builder = Builder::XmlMarkup.new :target => xml
      builder.storeSection :id => "0", :memberId => "0", :storeId => store, :parentSectionId => parent, 
        :caption => caption, :description => "", :visible => "true", :active => "true",
        :defaultMarkupProfile => "Medium", :imageType => "png",
        :defaultProductDescription => "", :defaultProductImageId => "0", :defaultProductName => "", :teaser => "",
        :sectionImageId => image, :sectionImageWidth => 150, :sectionImageHeight => 150, :itemsAcross => 4
      xml
    end
    
    def products_xml(design)
      xml = ""
      builder = Builder::XmlMarkup.new :target => xml
      builder.products do
        ::Product.all.each do |product|
          builder.product :name => product.name, :merchandiseId => product.cafepress_id, :storeId => design.store.name, :sectionId => design.cafepress_section_id, :sortPriority => product.sort_priority, :sellPrice => product.marketplace_price.to_f.round do
            builder.mediaConfiguration :name => product.default_region, :designId => (product.dark? ? (design.cafepress_dark_id? ? design.cafepress_dark_id : design.cafepress_id) : design.cafepress_id)
          end
        end
      end
      xml
    end
    
    ###
    ## Commenting out code is bad.  I'm bad.  Bad to the bone.
    #
  
    # Example of uploading an image via multipart form post:
    
    # def upload_thumbnail_image(design)
    #   url = URI.parse('http://upload.cafepress.com/image.upload.cp')
    #   File.open(design.image.path(:small)) do |png|
    #     req = Net::HTTP::Post::Multipart.new url.path,
    #       default_options.merge("cpFile1" => UploadIO.new(png, "image/png", design.image.path(:small)),"folder" => "Images")
    #     res = Net::HTTP.start(url.host, url.port) do |http|
    #       http.request(req)
    #     end
    #     puts res.inspect
    #     puts res.body
    #   end
    # end
    
    # Design definition with every attribute:
    
    # class Design
    #   include HappyMapper
    #   tag 'design'
    # 
    #   attribute :id, String
    #   attribute :name, String
    #   attribute :parent_id, String, :tag => "parentId"
    #   attribute :width, String
    #   attribute :height, String
    #   attribute :caption, String
    #   attribute :creator, String
    #   attribute :folder_id, String, :tag => "folderId"
    #   attribute :folder_name, String, :tag => "folderName"
    #   attribute :media_url, String, :tag => "mediaUrl"
    #   attribute :approval_status, String, :tag => "approvalStatus"
    # end
  
    # Format options for an http get:
  
    # def format_options(options)
    #   options.merge('appKey' => @app_key, 'userToken' => @user_token).collect do |key,value|
    #     "#{key.camelize}=#{URI.escape(value)}"
    #   end.join('&')
    #   puts options
    #   options
    # end
  end
end