// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  var pusher = new Pusher('c64ed78fbbddb570c529'); // Replace with your app key
  var channel = pusher.subscribe('private-nick');
  
  channel.bind('hit_own_ship', function(data) {
    logger(data.time, data.str);
  });
  channel.bind('lost_own_ship', function(data) {
    logger(data.time, data.str);
  });
  channel.bind('hit_their_ship', function(data) {
    logger(data.time, data.str);
  });
  channel.bind('lost_their_ship', function(data) {
    logger(data.time, data.str);
  });
  channel.bind('ready', function(d){
    alert("Ready to move..");
  });
});
var u = 1;
var logger = function(time, data){
  u++;
  $('#logger').prepend("<li>" + data + "</li>");
  newDiv = "<div><abbr id='abbr"+u+"' class='timeago' title='"+time+"'>" + time + "</abbr>"  + "<span>" + data + "</span></div>";
  $('#game-log').prepend(newDiv);
  $.titleAlert("* Socketships", {interval: 700});
  jQuery('#abbr'+u).timeago();
}
