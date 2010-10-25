xml.instruct! :xml, :version => "1.0", :standalone => "no"
xml.declare! :DOCTYPE, :svg, :PUBLIC, "-//W3C//DTD SVG 1.1//EN", "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
width = 300
height = 300
offset = 5
xml.svg :width => "100%", :height => "100%", :version => "1.1", :xmlns => "http://www.w3.org/2000/svg", "xmlns:xlink" => "http://www.w3.org/1999/xlink" do |svg|
  xml.font(:id => "HelveticaRoundedLTStd-Bd", :"horiz-adv-x" => "611"){ |font| font << render(:partial => "/fonts/helvetica_rounded_bold") }
  # svg.ellipse :cx => 0, :cy => 0, :rx => 10, :ry => 10, :style => "fill:green;stroke:rgb(0,0,100);stroke-width:2;"
  
  first_center =  { :x => width/3 + offset,   :y => width/3 - 2*offset   }
  second_center = { :x => width/3*2 - offset, :y => width/3*2 - 4*offset}
  radius = width/3 - offset*2
  svg.a "xlink:href" => "http://www.google.com" do
    svg.circle :cx => first_center[:x], :cy => first_center[:y], :r => radius, :stroke => "blue", :"stroke-width" => 0, :fill => "#0000ff", :"fill-opacity" => "0.5"
    svg.text @properties[:set_a_title], :x => first_center[:x], :y => first_center[:y], :"font-family" => "Helvetica Rounded LT Std", :"font-size" => "#{width/15}px", :fill => "black", :"alignment-baseline" => "central", :"text-anchor" => "middle"  
  
    svg.circle :cx => second_center[:x], :cy => second_center[:y], :r => radius, :stroke => "red", :"stroke-width" => 0, :fill => "#ff0000", :"fill-opacity" => "0.5"
    svg.text @properties[:set_b_title], :x => second_center[:x], :y => second_center[:y], :"font-family" => "Helvetica Rounded LT Std", :"font-size" => "#{width/15}px", :fill => "black", :"alignment-baseline" => "central", :"text-anchor" => "middle"  
  
    svg.text @properties[:intersection_title], :x => height/2, :y => height-height/30, :"font-family" => "Helvetica Rounded LT Std", :"font-size" => "#{width/15}px", :fill => "black", :"alignment-baseline" => "bottom", :"text-anchor" => "middle"
    
    svg.text "PREVIEW", :x => height/2, :y => 60, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => 60, :"fill-opacity" => 0.1
    svg.text "PREVIEW", :x => height/2, :y => height/2, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => 60, :"fill-opacity" => 0.1
    svg.text "PREVIEW", :x => height/2, :y => height-60, :"alignment-baseline" => "central", :"text-anchor" => "middle", :"font-size" => 60, :"fill-opacity" => 0.1
            
    svg.circle :cx => height/6, :cy => height/3*2, :r => 2, :fill => "red"
    # extract into an "arrow from x to y" module
    svg.path :d => "M#{height/3} #{height-height/30-width/15} S#{height/6} #{height/3*2} #{(second_center[:x]-first_center[:x])/2+first_center[:x]} #{(second_center[:y]-first_center[:y])/2+first_center[:y]}", :stroke => "black", :"stroke-width" => 2, :fill => "none"
    svg.path :d => "M#{(second_center[:x]-first_center[:x])/2+first_center[:x]} #{(second_center[:y]-first_center[:y])/2+first_center[:y]} S#{(second_center[:x]-first_center[:x])/2+first_center[:x]-10} #{(second_center[:y]-first_center[:y])/2+first_center[:y]+15} #{(second_center[:x]-first_center[:x])/2+first_center[:x]-20} #{(second_center[:y]-first_center[:y])/2+first_center[:y]+20}", :stroke => "black", :"stroke-width" => 2, :fill => "none"
    svg.path :d => "M#{(second_center[:x]-first_center[:x])/2+first_center[:x]} #{(second_center[:y]-first_center[:y])/2+first_center[:y]} S#{(second_center[:x]-first_center[:x])/2+first_center[:x]-15} #{(second_center[:y]-first_center[:y])/2+first_center[:y]-5} #{(second_center[:x]-first_center[:x])/2+first_center[:x]-30} #{(second_center[:y]-first_center[:y])/2+first_center[:y]}", :stroke => "black", :"stroke-width" => 2, :fill => "none"
  end
end