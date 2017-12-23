//Override the default confirm dialog by rails
$.rails.allowAction = function(link){
  if (link.data("confirm") == undefined){
    return true;
  }
  $.rails.showConfirmationDialog(link);
  return false;
}
//User click confirm button
$.rails.confirmed = function(link){
  link.data("confirm", null);
  link.trigger("click.rails");
}
//Display the confirmation dialog
$.rails.showConfirmationDialog = function(link){
  var message = link.data("confirm");
  swal({
    title: message,
    type: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes',
    cancelButtonText: 'No!',
    // buttonsStyling: false
  }).then(function () {
      $.rails.confirmed(link);
  }, function (dismiss) {
  // dismiss can be 'cancel', 'overlay',
  // 'close', and 'timer'
    if (dismiss === 'cancel') {
      swal(
        'Cancelled!!!',
        '',
        'info'
      )
    }
  })
}
