module DesignViews
  class Venn2 < Base
    def xml(markup, parameters, options={})
      width = options[:width] || 100
      height = options[:height] || 100
      
      offset = (5.to_f/300*height).to_i
      first_center =  { :x => width/3 + offset,   :y => width/3 - 2*offset   }
      second_center = { :x => width/3*2 - offset, :y => width/3*2 - 4*offset}
      radius = width/3 - offset*2
      arrow_size = 2.to_f*height/300
      
      set_a_color = "#0000FF"
      set_b_color = "#FF0000"
      
      font_family = "Helvetica Rounded LT Std"
      font_size = width/15
      font_color = "#000000"      
      font_options = {:"font-family" => font_family, :"font-size" => "#{font_size}px", :fill => font_color, :"alignment-baseline" => "bottom", :"text-anchor" => "middle"  }

      svg_image :xml => markup, :height => options[:height], :width => options[:width] do |svg|
        svg.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << Fonts::HelveticaRoundedBold }

        # Backgrounds
        svg.circle :cx => first_center[:x], :cy => first_center[:y], :r => radius, :fill => "#ffffff", :"fill-opacity" => "1"
        svg.circle :cx => second_center[:x], :cy => second_center[:y], :r => radius, :fill => "#ffffff", :"fill-opacity" => "0.5"

        svg.circle :cx => first_center[:x], :cy => first_center[:y], :r => radius, :fill => set_a_color, :"fill-opacity" => "0.5"
        svg.circle :cx => second_center[:x], :cy => second_center[:y], :r => radius, :fill => set_b_color, :"fill-opacity" => "0.5"
        
        svg.lines_of_text parameters[:set_a_title], font_options.merge(:x => first_center[:x], :y => first_center[:y]+font_size/2)
        svg.lines_of_text parameters[:set_b_title], font_options.merge(:x => second_center[:x], :y => second_center[:y]+font_size/2)
        
        # Intersection
        intersection_title = ::DesignViews::Helpers::String.new parameters[:intersection_title], :font_size => font_size
        svg.lines_of_text intersection_title, font_options.merge(:x => height/2, :y => height-height/30)
        svg.arrow(Vector[(width - intersection_title.max_width*0.80)/2, height-intersection_title.total_height-offset*1.5], Vector[(second_center[:x]-first_center[:x])/2+first_center[:x], (second_center[:y]-first_center[:y])/2+first_center[:y]], :curve_to => Vector[height/6, height/3*2], :stroke => font_color, :"stroke-width" => arrow_size, :fill => "none")

        svg.preview if options[:preview]
      end
    end
  end
end