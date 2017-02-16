// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require cable
// Loads all Semantic javascripts
//= require semantic-ui
//= require_tree .

setTimeout(function(){
   window.location.reload(1);
}, 10000);

setInterval('updateClock()', 200);

// This function gets the current time and injects it into the DOM
function updateClock() {
    // Gets the current time
    var now = new Date();

    // Get the hours, minutes and seconds from the current time
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var seconds = now.getSeconds();

    // Format hours, minutes and seconds
    if (hours < 10) {
        hours = "0" + hours;
    }
    if (minutes < 10) {
        minutes = "0" + minutes;
    }
    if (seconds < 10) {
        seconds = "0" + seconds;
    }

    // Gets the element we want to inject the clock into
    var elem = document.getElementById('clock');

    // Sets the elements inner HTML value to our clock data
    elem.innerHTML = hours + ':' + minutes + ':' + seconds;
}