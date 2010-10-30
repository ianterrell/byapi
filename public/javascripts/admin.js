jQuery(function ($) {
  $('a.lightbox').lightBox();
  $('#products').sortable({
    dropOnEmpty: false,
    cursor: 'crosshair',
    items: '.product',
    opacity: 0.4,
    scroll: true,
    update: function(){
      $.ajax({
        type: 'post',
        data: $('#products').sortable('serialize'),
        dataType: 'script',
        url: '/admin/products/sort',
        success: function(){
          $('#products').effect('highlight');
        }
      })
    }
  });
});