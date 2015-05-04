// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
var OpsAdsIndex = {
  init: function() {
    $('.ad-approve-now-button').click(function(ev) {
      ev.stopPropagation();
      var a = $(this);
      if (confirm(a.attr('data-ad-approvenow-prompt'))) {
        $.post(a.attr('data-ad-approvenow-path'), {'_method': 'put'}, function(data) {
          window.location.reload();
        }, 'json');
      }
    });
  }
};

if ($('.ad-approve-now-button').get(0)) {
  OpsAdsIndex.init();
}