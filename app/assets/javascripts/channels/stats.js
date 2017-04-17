
App.stats = App.cable.subscriptions.create('StatsChannel', {  
  received: function(data) {
    this.renderStats(data);
  },

  renderStats: function(data) {
  	$('#indoor_temp').text(data.indoor_temp);
  	$('#outdoor_temp').text(data.outdoor_temp);
  	$('#weather_icon').attr('class', 'wi-6x wi wi-' + data.weather);
  	if (data.current_message != null) {
  		$('#current_message').text(data.current_message);
  	} else {
  		$('#current_message').text('');
  	}
    // ok lets set the device status area
    // this is a little nasty - but it'll work
    // TODO - find a better way to write this?
    //console.log(data.device_status);
    device_status_html = "";
    //data.device_status.keys(obj).forEach (function (device, index, key){
    for (var device_name in data.device_status) {
      // which icon to use?
      if (data.device_status[device_name] == true) {
        icon = "home";
      } else {
        icon = "car";
      }

      device_status_html += "<div id='" + device_name + "_status'><i class='fa fa-" + icon + " fa-4x'></i></div>";

    };

    $('#home_status').html(device_status_html);
    $("#current_light_mode").html(data.current_light_mode);
    $('#dashboard').css("background-image", "url(" + data.weather_image + ")");
    message_datetime = Date.parse(data.time);
  }
});