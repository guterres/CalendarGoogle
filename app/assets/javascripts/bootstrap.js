jQuery(function() {
  $("a[rel~=popover], .has-popover").popover();
  $("a[rel~=tooltip], .has-tooltip").tooltip();
  $('#datepicker').datepicker({format: 'dd/mm/yyyy'})
  $('#datepicker1').datepicker({format: 'dd/mm/yyyy'})
  $('#datepicker2').datepicker({format: 'dd/mm/yyyy'})
  $('#datepicker3').datepicker({format: 'dd/mm/yyyy'})
  $('#timepicker').timepicker({showMeridian: false})
  $('#timepicker1').timepicker({showMeridian: false})
  $('#timepicker2').timepicker({showMeridian: false})
  $('#timepicker3').timepicker({showMeridian: false})
});
