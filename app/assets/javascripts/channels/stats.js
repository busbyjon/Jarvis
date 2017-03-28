
App.stats = App.cable.subscriptions.create('StatsChannel', {  
  received: function(data) {
    this.renderStats(data);
  },

  renderStats: function(data) {
  	$('#indoor_temp').text(data.indoor_temp);
  	$('#outdoor_temp').text(data.outdoor_temp);
  	$('#weather_icon').attr('class', 'wi-6x wi wi-' + data.weather);
  }
});