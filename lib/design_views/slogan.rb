module DesignViews
  class Slogan < Base
    def xml(markup, parameters, options={})
      width = options[:width] || 100
      height = options[:height] || 100
      
      offsets = ::DesignViews::Helpers::Offsets.new(options[:offsets], width)
      
      font_family = "Helvetica Rounded LT Std"
      
      string = parameters[:text]
      parsed_string = ::DesignViews::Helpers::String.new string
      
      font_width = 0
      font_height = 0
      font_size = 10.to_f/300*height
      max_width = 0.0
      guesstimate_height = 0
      while max_width < 0.999*width.to_f && guesstimate_height < height
        widths = []
        total_height = 0
        font_size += 5.to_f/300*height
        parsed_string.lines.each do |line|
          font_width, font_height, ascent, descent = Fonts.metrics_for line, :size => font_size
          widths << font_width
          total_height += font_height.to_i
        end
        guesstimate_height = total_height * 0.8
        max_width = widths.max.to_f
      end
      font_size -= 5.to_f/300*height
      
      font_color = options[:dark] ? "#FFFFFF" : "#000000"      
      
      x, alignment = if parameters[:alignment] == "left"
        [[(width.to_f - max_width)/2,0.02*width].max, "left"]
      else
        [width.to_f/2, "middle"]
      end
      
      y = if guesstimate_height < height.to_f/3
        height.to_f/3
      else
        height.to_f/2
      end
      
      svg_image :xml => markup, :height => height, :width => width do |svg|
        svg.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << Fonts::HelveticaRoundedBold }
        
        svg.lines_of_text string, :x => x, :y => y, "font-family" => font_family, "font-size" => "#{font_size}px", :fill => font_color, "alignment-baseline" => "central", "text-anchor" => alignment
        
        svg.rect :x => 0, :y => 0, :height => 300, :width => 300, :fill => "none", :stroke => "#000"
        # svg.preview if options[:preview]
      end
    end
  end
end