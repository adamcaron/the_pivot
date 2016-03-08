$(function() {
    $( "#check_in" ).datepicker({
      minDate: 0,
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 3,
      onClose: function( selectedDate ) {
        $( "#check_out" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( "#check_out" ).datepicker({
      minDate: 0,
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 3,
      onClose: function( selectedDate ) {
        $( "#check_in" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
  });
