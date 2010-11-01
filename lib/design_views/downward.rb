module DesignViews
  class Downward < Base
    def xml(markup, parameters, options={})
      width = options[:width] || 100
      height = options[:height] || 100
      
      offsets = ::DesignViews::Helpers::Offsets.new(options[:offsets], width)

      arrow_size = 2.to_f*height/300
      
      axes_offset = height/10
      curve = 3
      
      font_family = "Helvetica Rounded LT Std"
      font_size = width/15
      font_color = options[:dark] ? "#FFFFFF" : "#000000"      
      font_options = {:"font-family" => font_family, :"font-size" => "#{font_size}px", :fill => font_color, :"alignment-baseline" => "bottom", :"text-anchor" => "middle"  }

      svg_image :xml => markup, :height => height, :width => width do |svg|
        svg.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << Fonts::HelveticaRoundedBold }

        # X Axis
        svg.arrow(Vector[axes_offset, height - axes_offset], Vector[width-axes_offset, height-axes_offset], :head_length => width/30, :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none")
        # Label
        svg.lines_of_text parameters[:x_axis], font_options.merge(:x => width/2 + offsets.x("x_axis"), :y => height -0.3*font_size+ offsets.y("x_axis"))
        
        # Y Axis
        svg.arrow(Vector[axes_offset, height - axes_offset], Vector[axes_offset, axes_offset], :head_length => width/30, :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none")
        # Label
        svg.lines_of_text parameters[:y_axis], font_options.merge(:x => font_size + offsets.x("y_axis"), :y => height/2 + offsets.y("y_axis"), :transform => "rotate(-90 #{font_size + offsets.x("y_axis")} #{height/2 + offsets.y("y_axis")})")
        
        # Joining the axes nicely
        svg.path :d => "M#{axes_offset} #{height-2*axes_offset} L#{axes_offset} #{height-axes_offset} L#{2*axes_offset} #{height-axes_offset}", :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none"
        
        # Downward slope!
        svg.path :d => "M#{1.5*axes_offset} #{1.5*axes_offset} S#{curve*axes_offset} #{height-curve*axes_offset} #{width-1.5*axes_offset} #{height-1.5*axes_offset}", :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none"

        svg.preview if options[:preview]
      end
    end
  end
end