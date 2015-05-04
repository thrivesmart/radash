// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


if ($('select.multiselect').get(0)) {
  $('select.multiselect').multiselect();
  // $('input.server-tokenfield').tokenfield();
  $('select.searchable-multiselect').multiselect({enableFiltering: true});
  
  var engine = new Bloodhound({
    datumTokenizer: function(d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: '/reddit_proxy/subreddits.json'
    // TODO make searching work for when we have a bigger set of subreddits
    // ,
    // remote: {
    //   url: '/reddit_proxy/subreddits.json?q=%QUERY',
    //   wildcard: '%QUERY'
    // }
  });
  engine.initialize();
  $('.subreddits-tokenfield').tokenfield({
    typeahead: [null, { source: engine.ttAdapter(), display: 'value' }]
  });

  $('.manual-tokenfield').tokenfield();
}