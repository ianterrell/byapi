module DesignViews
  class Venn2 < Base
    def xml(markup, parameters, options={})
      width = options[:width] || 100
      height = options[:height] || 100
      
      offset = 5

      svg_image :xml => markup, :height => options[:height], :width => options[:width] do |svg|
        svg.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << Fonts::HelveticaRoundedBold }
        # svg.ellipse :cx => 0, :cy => 0, :rx => 10, :ry => 10, :style => "fill:green;stroke:rgb(0,0,100);stroke-width:2;"

        first_center =  { :x => width/3 + offset,   :y => width/3 - 2*offset   }
        second_center = { :x => width/3*2 - offset, :y => width/3*2 - 4*offset}
        radius = width/3 - offset*2
        svg.a "xlink:href" => "http://www.google.com" do
          svg.circle :cx => first_center[:x], :cy => first_center[:y], :r => radius, :stroke => "blue", :"stroke-width" => 0, :fill => "#0000ff", :"fill-opacity" => "0.5"
          svg.text parameters[:set_a_title], :x => first_center[:x], :y => first_center[:y], :"font-family" => "Helvetica Rounded LT Std", :"font-size" => "#{width/15}px", :fill => "black", :"alignment-baseline" => "central", :"text-anchor" => "middle"  

          svg.circle :cx => second_center[:x], :cy => second_center[:y], :r => radius, :stroke => "red", :"stroke-width" => 0, :fill => "#ff0000", :"fill-opacity" => "0.5"
          svg.text parameters[:set_b_title], :x => second_center[:x], :y => second_center[:y], :"font-family" => "Helvetica Rounded LT Std", :"font-size" => "#{width/15}px", :fill => "black", :"alignment-baseline" => "central", :"text-anchor" => "middle"  

          svg.text parameters[:intersection_title], :x => height/2, :y => height-height/30, :"font-family" => "Helvetica Rounded LT Std", :"font-size" => "#{width/15}px", :fill => "black", :"alignment-baseline" => "bottom", :"text-anchor" => "middle"

          svg.arrow(Vector[height/3, height-height/30-width/15], Vector[(second_center[:x]-first_center[:x])/2+first_center[:x], (second_center[:y]-first_center[:y])/2+first_center[:y]], :curve_to => Vector[height/6, height/3*2], :stroke => "black", :"stroke-width" => 2, :fill => "none")

          svg.preview
        end
      end
    end
  end
end