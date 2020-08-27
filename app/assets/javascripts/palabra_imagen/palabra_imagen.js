//= require jquery
//= require slabText/jquery.slabtext
//= require_self

// Function to slabtext the H1 headings
$(document).ready(function() {
   $("h1").slabText({
       // Don't slabtext the headers if the viewport is under 380px
  });
  $("#word_as_image_wrapper").css("margin-top", $("#word_as_image_wrapper").height()/-2);
});
