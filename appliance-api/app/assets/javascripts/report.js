'use strict';

function fillOutSummary(data) {
  $('.sad-count').html(data.sad_customer_count);
  $('.unreachable-count').html(data.unreachable_count);
}

function makePrettyTableData(details) {

  // I fully acknowledge that using map makes this incompatible with IE8.
  return details.map( function(item) {
      var reachable = item['reachable?'] ? 'yes' : 'no';
      return [item.appliance.customer, item.hostname, item.address, reachable];
    });
}

function makePie(data) {

  var config = {
    animation: false,
  }

  var unreachables = $('#unreachables').get(0).getContext('2d');
  return new Chart(unreachables).Pie(data, config);
}

function updatePie(pieChart, data) {
  pieChart.removeData();
  pieChart.addData( 
    {
      value: data.unreachable_count,
      color: '#B80015',
      label: 'Unreachable'
    });
  pieChart.addData({
      value: data.target_count - data.unreachable_count,
      color: '#8AA431',
      label: 'Reachable'
    });
}

function makeTable() {

  var table = $('#details').DataTable({
    'paging': false 
    }
  );
 
  return table;
}

function updateTable(table, details) {
  var data = makePrettyTableData(details);
  table.clear();
  table.rows.add(data).draw();
}

function loadPage(targetCount) {

  var pieChart = makePie([{value: targetCount, color: '#505050', label: 'Targets'}]);
  var table = makeTable();

  $.ajax({
    url: '/api/report-data',
    async: true,
    type: 'GET',
    dataType : 'json',
    timeout: 8000,
    success: function( json ) {
      fillOutSummary(json);
      updatePie(pieChart, json);
      updateTable(table, json.targets);
      $('.waiting').toggleClass('ninja');
    },
    error: function( xhr, status, errorThrown ) {
      $('.oops, .waiting, .overview, #details_wrapper').toggleClass('ninja');
    },
  });
};


