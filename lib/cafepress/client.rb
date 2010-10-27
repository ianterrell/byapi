require 'net/http'
require 'uri'

module Cafepress
  class Client
    attr_accessor :app_key, :user_token

    def initialize(app_key=CAFEPRESS[:app_key], user_token=CAFEPRESS[:user_token])
      @app_key = app_key
    end
    
    def save_design(design)
      puts post_form('design.save.cp', {"value" => design, "svg" => svg_body})
      # SearchResultSet.parse(Net::HTTP.get(query_url(options.merge('query' => query))))
    end
    
    def query_url(options = {})
      URI.parse("#{CAFEPRESS[:base_url}/design.save.cp")
    end
    
  protected
    def post_form(method, options)
      Net::HTTP.post_form url_for_method(method), format_options(options)
    end
    
    def url_for_method(method)
      URI.parse("#{CAFEPRESS[:base_url}/#{method}")
    end
  
    def format_options(options)
      options.merge('appKey' => @app_key, 'userToken' => @user_token).collect do |key,value|
        "#{key.camelize}=#{URI.escape(value)}"
      end.join('&')
    end
  end
end