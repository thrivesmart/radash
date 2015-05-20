// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

var CampaignForm = {
  flightTemplateHtml: null,
  flightCount: 0,
  init: function() {
    this.flightTemplateHtml = $('#flight-template').remove().html();
    $('#add-flight-button').click(function(ev) {
      CampaignForm.addFlight();
    }); 
  },
  addFlight: function() {
    var newFlightHtml = CampaignForm.flightTemplateHtml.replace(/_INDEX_/g, CampaignForm.flightCount++);
    var newFlight = $(newFlightHtml);
    $('#flights').append(newFlight);
    newFlight.find('.remove-flight-btn').click(function(ev) { 
      CampaignForm.removeFlight($(this)); 
    });
  },
  removeFlight: function(atag) {
    var i = atag.attr('data-remove-flight-index');
    $('#flight_'+i).remove();
  }
};

if ($('#add-flight-button').get(0)) {
  CampaignForm.init();
}


var CampaignShow = {
  init: function() {
    var target = $('#campaign-total-spent');
    $.getJSON(target.attr('data-endpoint') + "?spend=true", function(data) {
      $('#campaign-total-spent').text('$' + data.SpendInDollars);
    });
    
    // Fetch ad information from each row
    $('tr.campaign-ad-row').each(function(i,trEl) {
      var tr = $(trEl);
      var adId = tr.attr('data-ad-id');
      $.getJSON(target.attr('data-endpoint') + "?aid="+adId, function(data) {
        tr.find('td.impressions').text(data.TotalImpressions);
        tr.find('td.clicks').text(data.TotalClicks);
        var ctr = data.Ctr * 100.00;
        tr.find('td.ctr').text(ctr + "%");
      });
    });
  }
}

if ($('#campaign-total-spent').get(0)) {
  CampaignShow.init();
}