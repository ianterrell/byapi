module SvgHelper
  def svg_image(options = {}, &block)
    xml = options.delete(:xml) || eval("xml", block.binding)
    
    xml.instruct! :xml, :version => "1.0", :standalone => "no"
    xml.declare! :DOCTYPE, :svg, :PUBLIC, "-//W3C//DTD SVG 1.1//EN", "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
    
    options[:height] ||= 100
    options[:width] ||= 100
    
    svg_opts = { :width => options[:width], :height => options[:height], :version => "1.1", :xmlns => "http://www.w3.org/2000/svg", "xmlns:xlink" => "http://www.w3.org/1999/xlink" }
    xml.svg(svg_opts) do
      yield SvgImageBuilder.new(xml, self, options)
    end
  end

  class SvgBuilder
    def initialize(xml)
      @xml = xml
    end

  private
    def method_missing(method, *arguments, &block)
      @xml.__send__(method, *arguments, &block)
    end
  end

  class SvgImageBuilder < SvgBuilder
    def initialize(xml, view, options = {})
      @xml, @view, @options = xml, view, options
    end

    def arrow(from, to, options={})
      angleish = options.delete(:angleish) || 0.667
      curve_point = options.delete(:curve_to) || from
      head_length = options.delete(:head_length) || (to - from).r / 10

      line = to - from
      vector = (curve_point-to).normalize
      perp1 = Vector[-vector[1],vector[0]]*angleish
      perp2 = Vector[vector[1],-vector[0]]*angleish

      half1 = (vector + perp1).normalize
      half2 = (vector + perp2).normalize

      arrow1 = to + half1 * (line.r/5);
      arrow2 = to + half2 * (line.r/5);

      @xml.path options.merge(:d => "M#{from[0]} #{from[1]} S#{curve_point[0]} #{curve_point[1]} #{to[0]} #{to[1]}")
      @xml.path options.merge(:d => "M#{to[0]} #{to[1]} S#{arrow1[0]} #{arrow1[1]} #{arrow1[0]} #{arrow1[1]}")
      @xml.path options.merge(:d => "M#{to[0]} #{to[1]} S#{arrow2[0]} #{arrow2[1]} #{arrow2[0]} #{arrow2[1]}")
    end

    def preview(text="PREVIEW")
      font_size = @options[:height] / 5
      @xml.text text, :x => @options[:height]/2, :y => font_size, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => font_size, :"fill-opacity" => 0.1
      @xml.text text, :x => @options[:height]/2, :y => @options[:height]/2, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => font_size, :"fill-opacity" => 0.1
      @xml.text text, :x => @options[:height]/2, :y => @options[:height]-font_size, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => font_size, :"fill-opacity" => 0.1
    end
    
    def lines_of_text(text, options={})
      x = options.delete :x
      y = options.delete :y
      unless text.is_a? ::DesignViews::Helpers::String
        text = ::DesignViews::Helpers::String.new text, :font_size => (options[:"font-size"] || options["font-size"] || options[:font_size] || "10px").gsub("px","").to_i
      end
      text.lines.each_with_index do |line, index|
        @xml.text line, options.merge(:x => x, :y => text.vertical_center_for_line(index, :offset => y))
      end
    end

    # def font(name, options = {})
    #   @xml.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << render(:partial => "/fonts/helvetica_rounded_bold") }
    # end
  end

end
