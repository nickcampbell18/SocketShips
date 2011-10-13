//= require jquery
//= require jquery.timeago.js
//= require jquery.titlealert.js

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
    $("input#firebtn").attr('disabled',false);
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
