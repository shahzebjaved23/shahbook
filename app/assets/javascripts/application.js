// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require js-routes
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

var current_user_id = $(location).attr('href').match("[0-9]");
var lastFetch;
console.log(Routes.user_activity_feeds_path(7,{since: lastFetch}));

var pollActivity = function(){
	$.ajax({
		url: Routes.user_activity_feeds_path(7,{
				since: lastFetch
			 }),
		type: "GET",
		dataType: "json",
		success: function(data){
			lastFetch = Math.floor(new Date().getTime())/1000;
			console.log(Routes.user_activity_feeds_path(7,{since: lastFetch})); 
			console.log(data);
		},
		error: function(error){
			console.log(Routes.user_activity_feeds_path(7,{since: lastFetch}));
			console.log(error);
		}
	});
}

window.setInterval(pollActivity,5000);
