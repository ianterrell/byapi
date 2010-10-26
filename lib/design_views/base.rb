require 'builder'

module DesignViews
  class Base
    include SvgHelper
    
    def render(parameters, options={})
      buffer = ""
      markup = Builder::XmlMarkup.new(:target => buffer)
      xml(markup, parameters, options)
      return buffer.html_safe
    end
  end
end