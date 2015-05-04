// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
var OpsCreativesIndex = {
  init: function() {
    $('.creative-approve-now-button').click(function(ev) {
      ev.stopPropagation();
      var a = $(this);
      if (confirm(a.attr('data-creative-approvenow-prompt'))) {
        $.post(a.attr('data-creative-approvenow-path'), {'_method': 'put'}, function(data) {
          window.location.reload();
        }, 'json');
      }
    });
  }
};

if ($('.creative-approve-now-button').get(0)) {
  OpsCreativesIndex.init();
}