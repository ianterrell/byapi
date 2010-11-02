module DesignViews
  class Gay < Base
    def xml(markup, parameters, options={})
      width = options[:width] || 100
      height = options[:height] || 100
      
      offsets = ::DesignViews::Helpers::Offsets.new(options[:offsets], width)
      
      
      font_family = "Helvetica Rounded LT Std"
      
      string = parameters[:text]
      font_width = 0
      font_height = 0
      ascent = 0
      descent = 0
      font_size = 10
      while font_width.to_f < 0.999*width.to_f
        font_size += 5
        font_width, font_height, ascent, descent = Fonts.metrics_for string, :size => font_size
      end
      font_size -= 5
      
      #font_size = height/2
      font_color = options[:dark] ? "#FFFFFF" : "#000000"      
      font_options = {:"font-family" => font_family, :"font-size" => "#{font_size}px", :fill => font_color, :"alignment-baseline" => "bottom", :"text-anchor" => "middle"  }
      
      flag_colors = ["#f00000", "#ff8000", "#ffff00", "#007940", "#4040ff", "#a000c0"]
      flag_top = 35.0 + parameters[:top].to_f
      flag_height = font_height.to_f + parameters[:height].to_f
      stripe_size = (flag_height / flag_colors.size).round

      svg_image :xml => markup, :height => height, :width => width do |svg|
        svg.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << Fonts::HelveticaRoundedBold }
        
        svg.clipPath :id => "copyPath" do
          svg.lines_of_text string, font_options.merge(:x => width.to_f/2, :y => height.to_f/2)
        end
        
        # Flag
        flag_colors.each_with_index do |color, index|
          svg.rect :x => 0, :y => flag_top + index * stripe_size, :height => stripe_size, :width => width, :fill => color, :stroke => "none", :"clip-path" => "url(#copyPath)"
        end
        # svg.circle :cx => first_center[:x], :cy => first_center[:y], :r => radius, :fill => "#ffffff", :"fill-opacity" => "1"


      
        # svg.preview if options[:preview]
      end
    end
  end
end