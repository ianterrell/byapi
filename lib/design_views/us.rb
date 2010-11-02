module DesignViews
  class Us < Base
    def xml(markup, parameters, options={})
      width = 600#options[:width] || 100
      height = 600#options[:height] || 100
      
      offsets = ::DesignViews::Helpers::Offsets.new(options[:offsets], width)
      
      font_family = "Helvetica Rounded LT Std"
      font_size = height/2
      
      string = "'Murrka"
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
      
      original_font_size = font_size
      # font_height = font_height.to_f-descent.to_f
      
      flag_width_factor = 1235.to_f/font_width.to_f
      flag_height_factor = 650.to_f/font_height.to_f

      flag_width_factor = [flag_width_factor, flag_height_factor].min
      
      scale_factor = 1.0/flag_width_factor
      other_scale_factor = 1.0/flag_height_factor
      # font_size = height/2*flag_width_factor
      
      x_offset = width/2-0.5*font_width.to_f
      y_offset = height/2-0.5*font_height.to_f
      
      font_color = options[:dark] ? "#FFFFFF" : "#000000"      
      font_options = {:"font-family" => font_family, :"font-size" => "#{font_size}px", :fill => font_color, :"alignment-baseline" => "central", :"text-anchor" => "middle"  }
      
      
      puts scale_factor
      puts flag_width_factor
      
      puts x_offset
      puts y_offset
      
      y_boost = (y_offset-height.to_f/5)*flag_width_factor

      svg_image :xml => markup, :height => height, :width => width do |svg|
        svg.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << Fonts::HelveticaRoundedBold }

        # bounds: 6,-2  84,107
        # svg.rect :x => x_offset, :y => y_offset, :height => font_height.to_f-41, :width => font_width, :stroke => "#000", :fill => "none"
        # svg.rect :x => x_offset, :y => y_offset, :height => font_height.to_f, :width => font_width, :stroke => "#f00", :fill => "none"  
        # svg.lines_of_text string, font_options.merge(:"font-size" => "#{height.to_f/2}px", :x => width.to_f/2, :y => height.to_f/2)
        
        svg.clipPath :id => "copyPath" do
          svg.lines_of_text string, font_options.merge(:"font-size" => "#{original_font_size}px", :x => width.to_f/2, :y => height.to_f/2, :transform => "scale(#{1.0/scale_factor}) translate(#{-x_offset} #{-y_offset})")
        end

                
        svg.g :transform => "scale(#{scale_factor}) translate(#{x_offset*flag_width_factor} #{y_offset*flag_width_factor-y_boost})", :"clip-path" => "url(#copyPath)" do
          svg << Assets::USFlag 
        end
        
        # svg.rect :x => x_offset, :y => y_offset, :height => font_height.to_f-41, :width => font_width, :stroke => "#000", :fill => "none"
        # svg.circle :cx => 150, :cy => 150, :r => 3, :fill => "#00f"
        # svg.rect :x => 0, :y => 0, :height => height, :width => width, :stroke => "#000", :fill => "none"
        # Flag
        # flag_colors.each_with_index do |color, index|
        #   svg.rect :x => 0, :y => flag_top + index * stripe_size, :height => stripe_size, :width => width, :fill => color, :stroke => "none", :"clip-path" => "url(#copyPath)"
        # end

      
        svg.preview if options[:preview]
      end
    end
  end
end