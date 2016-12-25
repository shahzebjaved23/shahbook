// (function(){
// 	var user_id = $("body").data("user-id");
// 	console.log("current user id is " + user_id);
// });

App.activity_feeds = App.cable.subscriptions.create("ActivityFeedsChannel",{
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log("connected to the activity_feeds channel");
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);
  }
});
