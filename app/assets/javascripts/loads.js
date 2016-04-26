$(document).on('ready page:load', function(){
  $('.btn.add-orders').click(function(){
    var data = {ids: []};
    $('form.edit_load input[name="load[order_ids][]"]').each(function(){
      if($(this).val())
        data.ids.push($(this).val());
    });
    $.post($(this).attr('href'), data, function(result){
      var modal = $('.modal-holder').html('').append(result).find('.modal').modal();
      modal.find('.btn-ok').click(function(){
        modal.find('.select-checkbox:checked').each(function(){
          $('form.edit_load').append('<input type="hidden" name="load[order_ids][]" value='+$(this).val()+' />');
        });
        $('form.edit_load').submit()
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