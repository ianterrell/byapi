module DesignViews
  module Helpers
    class String < ::String
      def initialize(string, options={})
        super string
        @font_size = options.delete(:font_size) || 10
        @line_spacing = options.delete(:line_spacing) || 0
      end
      
      def parsed_string
        self.gsub("|","\n")
      end
      
      def lines
        self.split("|")
      end
      
      def line_count
        @line_count ||= self.lines.size
      end
      
      def vertical_center_for_line(index, options={})
        offset = options.delete(:offset) || 0
        middle_index = (line_count - 1).to_f/2
        factor  = index.to_f - middle_index
        offset + factor * @font_size + factor * @line_spacing
      end
      
      def total_height(options={})
        
        puts line_count * @font_size + (line_count-1) * @line_spacing
        line_count * @font_size + (line_count-1) * @line_spacing
      end
      
      def max_width(options={})
        lines.map{|x|x.size}.max * @font_size * 0.5
      end
    end
  end
end