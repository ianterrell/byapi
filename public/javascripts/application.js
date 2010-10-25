// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var selectedPattern;

function patternWithId(patternId) {
  var result;
  $(patterns).each(function(index, element){
    if (element.pattern.id == patternId)
      result = element.pattern;
  });
  return result;
}

function previewDesign() {
  var previewPath = $("#embedded-preview").attr('data-preview-path');
  var path = previewPath.replace('REPLACE', selectedPattern.id);
  var properties = [];
  $('#properties input').each(function(index, input){
    properties.push({name:$(input).attr('data-name'), value:$(input).val()});
  });
  path += "?" + properties.map(function(object){return "properties["+ object.name + "]=" + escape(object.value)}).join('&');
  $("#preview-div").html('<embed id="embedded-preview" data-preview-path="' + previewPath + '" src ="' + path + '" width="300" height="300" type="image/svg+xml"></embed>');
}

jQuery(function ($) {
  $('.pattern').live('click', function(){
    selectedPattern = patternWithId($(this).attr('data-pattern-id'));
    $('#patterns').slideUp();
    
    $('#pattern-name').html(selectedPattern.name);
    $('#design_pattern_id').val(selectedPattern.id);
    
    $(selectedPattern.properties).each(function(index, property){
      var label = $('<label>');
      label.attr('for', "design_properties_" + property.name);
      label.html(property.title);
      var input = $('<input>');
      if (property.type == "string")
        input.attr('type', 'text');
      input.attr('id', "design_properties_" + property.name);  
      input.attr('name', "design[properties][" + property.name + "]");
      input.attr('data-name', property.name)
      input.val(property.default)
      $('#properties').append(label);
      $('#properties').append(input);
      $('#properties').append('<br/>');
    });
    
    previewDesign();
    $('#new_design').slideDown();
    // alert(patternWithId($(this).attr('data-pattern-id')).name);
  });
  
  $('#preview-design').live('click', function(){
    previewDesign();
    return false;
  });
  
  // $('.track-events').live('click', function(){
  //   _gaq.push(['_trackEvent', $(this).attr('data-event-category'), $(this).attr('data-event-action'), $(this).attr('data-event-label')]);
  //   return true;
  // });
});