// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


if ($('select.multiselect').get(0)) {
  $('select.multiselect').multiselect();
  $('select.server-multiselect').multiselect({enableFiltering: true});
  $('select.searchable-multiselect').multiselect({enableFiltering: true});
  
}