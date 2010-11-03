module DesignViews
  class Qrcode < Base
    def xml(markup, parameters, options={})
      width = options[:width] || 100
      height = options[:height] || 100
      
      size = 1
      code = nil
      while code.blank?
        begin
          code = RQRCode::QRCode.new parameters[:string], :size => size
        rescue
          puts $!.class, $!.message
          size += 1
        end
      end
      block_size = width.to_f/code.modules.size
      
      svg_image :xml => markup, :height => height, :width => width do |svg|
         code.modules.each_index do |c|
           code.modules.each_index do |r|
             if code.is_dark(c,r)
               svg.rect :x => r*block_size, :y => c*block_size, :height => block_size, :width => block_size, :fill => "#000", :stroke => "#000"
             else
               svg.rect :x => r*block_size, :y => c*block_size, :height => block_size, :width => block_size, :fill => "#FFF", :stroke => "none"
             end
           end 
        end

        if options[:preview]
          font_size = height / 3
          svg.text "Preview", :x => height/2, :y => height/2-font_size, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => font_size, :"fill-opacity" => "0.75", :fill => "#0f0"
          svg.text "Preview", :x => height/2, :y => height/2, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => font_size, :"fill-opacity" => "0.75", :fill => "#0f0"
          svg.text "Preview", :x => height/2, :y => height/2+font_size, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => font_size, :"fill-opacity" => "0.75", :fill => "#0f0"
        end
      end
    end
  end
end