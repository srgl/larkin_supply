$(document).on('ready page:load', function(){
  $('.btn.add-order').click(function(){
    var data = {order_ids: []};
    $.post($(this).attr('href'), data, function(result){
      var modal_holder = $('.modal-holder');
      var modal = modal_holder.html('').append(result).find('.modal').modal();
      modal.find('.add-btn').on('click', function(){
        var data = {'_method': 'post', order_ids: []};
        modal.find('.select-checkbox:checked').each(function(){
          data.order_ids.push($(this).val());
          $('.edit_load').append('<input type="hidden" name="order_ids[]" value='+$(this).val()+' />');
        });
        $('.edit_load').submit()

      });
    });
    return false;
  });


  $('.commands .move-up').click(function(){
    var row = $(this).closest('tr');
    var previousRow = row.prev('tr');
    if(previousRow.length){
      row.insertBefore(previousRow);
    }
    return false;
  });

  $('.commands .move-down').click(function(){
    var row = $(this).closest('tr');
    var nextRow = row.next('tr');
    if(nextRow.length){
      row.insertAfter(nextRow);
    }
    return false;
  });

  $('.commands .remove').click(function(){
    $(this).closest('tr').remove();
    return false;
  });
});