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
//= require_tree ./channels
//= require_tree .


setInterval('updateClock()', 200);

// This function gets the current time and injects it into the DOM
function updateClock() {
    // Gets the current time
    var now = new Date();

    // Get the hours, minutes and seconds from the current time
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var seconds = now.getSeconds();

    var day = now.getDate();
    var month = now.getMonth()+1;
    var year = now.getFullYear();

    var weekday=new Array(7);
    weekday[1]="Monday";
    weekday[2]="Tuesday";
    weekday[3]="Wednesday";
    weekday[4]="Thursday";
    weekday[5]="Friday";
    weekday[6]="Saturday";
    weekday[0]="Sunday";

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
    elem.innerHTML = hours + ':' + minutes;

    // Gets the element we want to inject the clock into
    var day_elem = document.getElementById('day');

    // Sets the elements inner HTML value to our clock data
    day_elem.innerHTML = weekday[now.getDay()]

    // Gets the element we want to inject the clock into
    var date_elem = document.getElementById('date');

    // Sets the elements inner HTML value to our clock data
    date_elem.innerHTML = day + '/' + month + '/' + year;
}