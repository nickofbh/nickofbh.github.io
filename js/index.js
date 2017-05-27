$(function() {
  $(".picture > img").hover(function() {
    $(this).siblings(".image-subtitle").css('opacity', '1.0');
  }, function() {
    $(this).siblings(".image-subtitle").css('opacity', '0.0');
  });
});
