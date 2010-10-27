require 'net/http'
require 'net/http/post/multipart'
require 'builder'
require 'uri'

module Cafepress
  class Client
    attr_accessor :app_key, :user_token

    def initialize(app_key=CAFEPRESS[:app_key], user_token=CAFEPRESS[:user_token])
      @app_key, @user_token = app_key, user_token
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
    
    def create_top_level_for_design(design)
      xml = top_level_section_xml design
      response = post_form('store.saveStoreSection.cp', default_options.merge("value" => xml))
      response.is_a?(Net::HTTPOK) ? StoreSection.parse(response.body) : false
    end

    def create_second_level_section_for_design(design, section)
      xml = section_xml(design, design.cafepress_top_section_id, section, "0")
      response = post_form('store.saveStoreSection.cp', default_options.merge("value" => xml))
      response.is_a?(Net::HTTPOK) ? StoreSection.parse(response.body) : false
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
    
  protected
    def post_form(method, options)
      Net::HTTP.post_form url_for_method(method), options
    end
    
    def url_for_method(method)
      URI.parse("#{CAFEPRESS[:base_url]}/#{method}")
    end
  
    def default_options
      {'appKey' => @app_key, 'userToken' => @user_token}
    end
    
    def blank_design_xml(design)
      xml = ""
      builder = Builder::XmlMarkup.new :target => xml
      builder.design :caption => "#{design.id}: #{design.title}"
      xml
    end
    
    #<storeSection id="0" memberId="0" storeId="" parentSectionId="0" 
    #caption="A caption" description="A description" visible="true" 
    #active="true" defaultMarkupProfile="Medium" defaultProductMarkup="1" 
    #sectionImageId="0" sectionImageWidth="100" sectionImageHeight="100" 
    #sortPriority="1" itemsAcross="3" categoryId="1" imageType="jpg" 
    #defaultProductDescription="A product description." defaultProductImageId="0" 
    #defaultProductName="product name" teaser="Section Teaser" />
    def top_level_section_xml(design)
      section_xml(design, "0", design.title, design.cafepress_id)
    end
    
    def section_xml(design, parent, caption, image)
      xml = ""
      builder = Builder::XmlMarkup.new :target => xml
      builder.storeSection :id => "0", :memberId => "0", :storeId => design.site.current_store.name, :parentSectionId => parent, 
        :caption => caption, :description => "", :visible => "true", :active => "true",
        :defaultMarkupProfile => "Medium", :imageType => "png",
        :defaultProductDescription => "", :defaultProductImageId => "0", :defaultProductName => "", :teaser => "",
        :sectionImageId => image, :sectionImageWidth => 150, :sectionImageHeight => 150, :itemsAcross => 4
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