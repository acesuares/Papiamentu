$(document).foundation();

// initialize datepickers
  $(document).ready(function() {
    $.datepicker.setDefaults({
      changeMonth : true,
      changeYear : true,
      yearRange: '-100:+100'
    });
  });

// get rid of translation_missing tooltips
  $(document).ready(function() {
    $(this).on('mouseover', '.translation_missing', function() {
      $(this).attr('title', '');
    });
  });

    // Function to slabtext the H1 headings
   $(document).ready(function() {
       $("h1").slabText({
           // Don't slabtext the headers if the viewport is under 380px
           "viewportBreakpoint":380
       });
   }
  );
