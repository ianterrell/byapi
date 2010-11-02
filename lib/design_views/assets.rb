module DesignViews
  module Assets
    USFlag = <<-XML
    <defs>
    <polygon id="pt" points="-0.1624598481164531,0 0,-0.5 0.1624598481164531,0" transform="scale(0.0616)" fill="#FFF"/>
    <g id="star"><use xlink:href="#pt" transform="rotate(-144)"/><use xlink:href="#pt" transform="rotate(-72)"/><use xlink:href="#pt"/><use xlink:href="#pt" transform="rotate(72)"/><use xlink:href="#pt" transform="rotate(144)"/></g>
    <g id="s5"><use xlink:href="#star" x="-0.252"/><use xlink:href="#star" x="-0.126"/><use xlink:href="#star"/><use xlink:href="#star" x="0.126"/><use xlink:href="#star" x="0.252"/></g>
    <g id="s6"><use xlink:href="#s5" x="-0.063"/><use xlink:href="#star" x="0.315"/></g>
    <g id="x4"><use xlink:href="#s6"/><use xlink:href="#s5" y="0.054"/><use xlink:href="#s6" y="0.108"/><use xlink:href="#s5" y="0.162"/></g>
    <g id="u"><use xlink:href="#x4" y="-0.216"/><use xlink:href="#x4"/><use xlink:href="#s6" y="0.216"/></g>
    <rect id="stripe" width="1235" height="50" fill="#B22234"/>
    </defs>
    <rect width="1235" height="650" fill="#FFF"/><use xlink:href="#stripe"/><use xlink:href="#stripe" y="100"/><use xlink:href="#stripe" y="200"/><use xlink:href="#stripe" y="300"/><use xlink:href="#stripe" y="400"/><use xlink:href="#stripe" y="500"/><use xlink:href="#stripe" y="600"/><rect width="494" height="350" fill="#3C3B6E"/><use xlink:href="#u" transform="translate(247,175) scale(650)"/>
    XML
  end
end