module DesignViews
  class Venn2 < Base
    def xml(markup, parameters, options={})
      width = options[:width] || 100
      height = options[:height] || 100
      offsets = ::DesignViews::Helpers::Offsets.new(options[:offsets], width)
      circle_offset = (parameters[:shrink_circles].to_f/300*height).to_i
      first_center =  { :x => width/3 + circle_offset,   :y => width/3 - 2*circle_offset   }
      second_center = { :x => width/3*2 - circle_offset, :y => width/3*2 - 4*circle_offset}
      radius = width/3 - circle_offset*2
      arrow_size = 2.to_f*height/300
      
      # Future:  color schemes?
      set_a_color = "#0000FF"
      set_b_color = "#FF0000"
      
      font_family = "Helvetica Rounded LT Std"
      font_size = width/15
      font_color = options[:dark] ? "#FFFFFF" : "#000000"      
      font_options = {:"font-family" => font_family, :"font-size" => "#{font_size}px", :fill => font_color, :"alignment-baseline" => "bottom", :"text-anchor" => "middle"  }

      svg_image :xml => markup, :height => options[:height], :width => options[:width] do |svg|
        svg.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << Fonts::HelveticaRoundedBold }

        # Backgrounds
        svg.circle :cx => first_center[:x], :cy => first_center[:y], :r => radius, :fill => "#ffffff", :"fill-opacity" => "1"
        svg.circle :cx => second_center[:x], :cy => second_center[:y], :r => radius, :fill => "#ffffff", :"fill-opacity" => "1"

        svg.circle :cx => first_center[:x], :cy => first_center[:y], :r => radius, :fill => set_a_color, :"fill-opacity" => "0.5"
        svg.circle :cx => second_center[:x], :cy => second_center[:y], :r => radius, :fill => set_b_color, :"fill-opacity" => "0.5"
        
        svg.lines_of_text parameters[:set_a_title], font_options.merge(:x => first_center[:x] + offsets.x("set_a"), :y => first_center[:y]+font_size/2+offsets.y("set_a"))
        svg.lines_of_text parameters[:set_b_title], font_options.merge(:x => second_center[:x] + offsets.x("set_b"), :y => second_center[:y]+font_size/2+offsets.y("set_b"))
        
        # Intersection
        parameters[:intersection_title] = "A: " + parameters[:intersection_title] if parameters[:style] == "label"
        intersection_title = ::DesignViews::Helpers::String.new parameters[:intersection_title], :font_size => font_size
        svg.lines_of_text intersection_title, font_options.merge(:x => height/2 + offsets.x("intersection"), :y => height-height/30 + offsets.y("intersection"))
        if parameters[:style] == "label"
          svg.lines_of_text "A", font_options.merge(:x => (second_center[:x]-first_center[:x])/2+first_center[:x], :y => (second_center[:y]-first_center[:y])/2+first_center[:y]+font_size.to_f/2)
        else
          svg.arrow(Vector[(width - intersection_title.max_width*0.80)/2 + offsets.x("arrow"), height-intersection_title.total_height-circle_offset*1.5 + offsets.y("arrow")], Vector[(second_center[:x]-first_center[:x])/2+first_center[:x], (second_center[:y]-first_center[:y])/2+first_center[:y]], :curve_to => Vector[height/6, height/3*2], :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none")
        end
        
        svg.preview if options[:preview]
      end
    end
  end
end