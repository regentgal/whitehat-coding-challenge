'use strict';
function buildUnreachablesPie(vals, selector) {
  
  var pieData = [
    {
      value: vals.unreachable,
      color: '#A00016'
    },
    {
      value : vals.reachable,
      color : '#228F00'
    }
  ];
  
  var pieOptions = {
    segmentShowStroke : false,
    animateScale : true
  };
  
  var unreachables = document.querySelector(selector).getContext('2d');
  new Chart(unreachables).Pie(pieData, pieOptions);

};
