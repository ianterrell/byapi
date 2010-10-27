module DesignsHelper
  def new_design?
    action_name == "new"
  end
  
  def offsets_blank?
    !offsets_entered?
  end
  
  def offsets_entered?
    @design.offsets.each_value do |coords|
      coords.each_value do |offset|
        return true if offset.to_i != 0
      end
    end
    false
  end
  
  def label_for_property(property)
    %|<label for="design_properties_#{property[:name]}">#{property[:title]}</label>|.html_safe
  end
  
  def input_for_property(property, value)
    type = if property.type == "string"
      'text'
    end
    %|<input type="#{type}" id="design_properties_#{property[:name]}" name="design[properties][#{property[:name]}]" data-name="#{property[:name]}" value="#{value}">|.html_safe
  end
  
  def input_for_offset(offset, axis, value)
    %|<input class="offset" type="text" id="design_offsets_#{offset[:name]}_#{axis}" name="design[offsets][#{offset[:name]}][#{axis}]" data-name="offsets[#{offset[:name]}][#{axis}]" value="#{value}">|.html_safe
  end
  
end
