$(function() {
  var pusher = new Pusher('c64ed78fbbddb570c529'); // Replace with your app key
  var channel = pusher.subscribe('private-' + pushKey);
  
  channel.bind('hit_own_ship', function(data) {
    logger(data.time, data.str, data.priority);
  });
  channel.bind('lost_own_ship', function(data) {
    logger(data.time, data.str, data.priority);
  });
  channel.bind('hit_their_ship', function(data) {
    logger(data.time, data.str, data.priority);
  });
  channel.bind('lost_their_ship', function(data) {
    logger(data.time, data.str, data.priority);
  });
  channel.bind('ready', function(d){
    $("input#firebtn").attr('disabled',false);
  });
});
var u = 1;
var logger = function(time, data, priority){
  u++;
  cls = (priority == 1 ? 'error' : 'info')
  newDiv = "<div class='alert-message " + cls + "'>" +
     "<span>" + data + "</span>" +
    "<abbr id='abbr"+u+"' class='timeago pull-right' title='"+time+"'>" + time + "</abbr>"  +
     "</div>";
  $('#game-log').prepend(newDiv);
  $.titleAlert("* Socketships", {interval: 700});
  jQuery('#abbr'+u).timeago();
}
