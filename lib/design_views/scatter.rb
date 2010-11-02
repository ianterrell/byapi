module DesignViews
  class Scatter < Base
    def xml(markup, parameters, options={})
      width = options[:width] || 100
      height = options[:height] || 100
      
      offsets = ::DesignViews::Helpers::Offsets.new(options[:offsets], width)

      arrow_size = 2.to_f*height/300
      
      axes_offset = height/10
      curve = 4
      point_radius = 5.to_f*height/300
      
      font_family = "Helvetica Rounded LT Std"
      font_size = width/15
      font_color = options[:dark] ? "#FFFFFF" : "#000000"      
      font_options = {:"font-family" => font_family, :"font-size" => "#{font_size}px", :fill => font_color, :"alignment-baseline" => "bottom", :"text-anchor" => "middle"  }

      svg_image :xml => markup, :height => height, :width => width do |svg|
        svg.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << Fonts::HelveticaRoundedBold }

        # X Axis
        svg.arrow(Vector[1.5*axes_offset, height - axes_offset], Vector[width-0.5*axes_offset, height-axes_offset], :head_length => width/30, :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none")
        # Label
        svg.lines_of_text parameters[:x_axis], font_options.merge(:x => 0.5*axes_offset+width/2 + offsets.x("x_axis"), :y => height -0.3*font_size+ offsets.y("x_axis"))
        
        # Y Axis
        svg.arrow(Vector[1.5*axes_offset, height - axes_offset], Vector[1.5*axes_offset, axes_offset], :head_length => width/30, :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none")
        # Label
        svg.lines_of_text parameters[:y_axis], font_options.merge(:x => 0.5*axes_offset + font_size + offsets.x("y_axis"), :y => height/2 + offsets.y("y_axis"), :transform => "rotate(-90 #{0.5*axes_offset + font_size + offsets.x("y_axis")} #{height/2 + offsets.y("y_axis")})")
        
        # Joining the axes nicely
        svg.path :d => "M#{1.5*axes_offset} #{height-2*axes_offset} L#{1.5*axes_offset} #{height-axes_offset} L#{2*axes_offset} #{height-axes_offset}", :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none"
        
        unless parameters[:low_low].blank?
          svg.circle :cx => 2.5*axes_offset + offsets.x("low_low_point"), :cy => height-2*axes_offset + offsets.y("low_low_point"), :r => point_radius, :fill => font_color, :"fill-opacity" => "1"
          svg.lines_of_text parameters[:low_low], font_options.merge(:x => 2*axes_offset + offsets.x("low_low_label"), :y => height-2*axes_offset-0.5*font_size + offsets.y("low_low_label"), :"text-anchor" => "start")
        end
        
        unless parameters[:low_high].blank?
          svg.circle :cx => 2.5*axes_offset + offsets.x("low_high_point"), :cy => 2*axes_offset + offsets.y("low_high_point"), :r => point_radius, :fill => font_color, :"fill-opacity" => "1"
          svg.lines_of_text parameters[:low_high], font_options.merge(:x => 2*axes_offset + offsets.x("low_high_label"), :y => 2*axes_offset-0.5*font_size + offsets.y("low_high_label"), :"text-anchor" => "start")
        end
        
        unless parameters[:high_low].blank?
          svg.circle :cx => width-1.5*axes_offset + offsets.x("high_low_point"), :cy => height-2*axes_offset + offsets.y("high_low_point"), :r => point_radius, :fill => font_color, :"fill-opacity" => "1"
          svg.lines_of_text parameters[:high_low], font_options.merge(:x => width-0.5*axes_offset + offsets.x("high_low_label"), :y => height-2*axes_offset-0.5*font_size + offsets.y("high_low_label"), :"text-anchor" => "end")
        end
        
        unless parameters[:high_high].blank?
          svg.circle :cx => width-1.5*axes_offset + offsets.x("high_high_point"), :cy => 2*axes_offset + offsets.y("high_high_point"), :r => point_radius, :fill => font_color, :"fill-opacity" => "1"
          svg.lines_of_text parameters[:high_high], font_options.merge(:x => width-0.5*axes_offset + offsets.x("high_high_label"), :y => 2*axes_offset-0.5*font_size + offsets.y("high_high_label"), :"text-anchor" => "end")
        end

        svg.preview if options[:preview]
      end
    end
  end
end