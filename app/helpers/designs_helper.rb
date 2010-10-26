module DesignsHelper
  def new_design?
    action_name == "new"
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
  
end
