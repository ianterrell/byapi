module DesignViews
  module Helpers
    class String < ::String
      def parsed_string
        self.gsub("|","\n")
      end
      
      def lines
        self.split("|")
      end
      
      def vertical_center(options={})
        offset = options.delete :offset || 0
        font_size = options.delete :font_size || 16
        
      end
    end
  end
end