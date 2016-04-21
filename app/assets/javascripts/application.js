// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-datepicker/core
//= require_tree .

$(document).on('ready page:load', function(){
  $('input#select-all-checkbox').click(function(){
    $('input.select-checkbox').prop('checked', $(this).prop('checked'));
  });

  $('input.select-checkbox, input#select-all-checkbox').click(function(){
    var checked = $('input.select-checkbox:checked');
    $('.btn.delete-btn').toggleClass('disabled', !checked.length);
    $('.btn.create-load-btn').toggleClass('disabled', !checked.length);
  });

  $('.btn.delete-btn').click(function(e){
    e.preventDefault();
    var checked = $('input.select-checkbox:checked');
    if(!confirm(['Are you sure you want to delete', checked.length, 'record(s)?'].join(' ')))
      return;

    var data = {"_method":"delete", "ids": []};
    checked.each(function(){
      data.ids.push($(this).val());
    })
    $.ajax({
      type: "POST",
      url: $(this).attr('href'),
      dataType: "json",
      data: data,
      success: function(data){
        location = data.redirect;
      }
    });
  });

  $('.btn.create-load-btn').click(function(e){
    e.preventDefault();
    var checked = $('input.select-checkbox:checked');
    var data = {load: {order_ids: []}};
    checked.each(function(){
      data.load.order_ids.push($(this).val());
    });
    $.ajax({
      type: "POST",
      url: $(this).attr('href'),
      dataType: "json",
      data: data,
      success: function(data) {
        location = data.redirect;
      }
    });
  })
});