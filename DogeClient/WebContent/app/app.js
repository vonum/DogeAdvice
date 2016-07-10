var dogeApp = angular.module("dogeApp", ["ngRoute", "ngWebSocket"]);

dogeApp.config(function($routeProvider) {
	$routeProvider
	.when('/', {
		templateUrl: "app/view/home.html",
		controller: "homeController"
	})
	.when('/start', {
		templateUrl: "app/view/start.html",
		controller: "startController"
	})
	.when('/diagnose', {
		templateUrl: "app/view/diagnose.html",
		controller: "diagnoseController"
	})
	.when('/history', {
		templateUrl: "app/view/history.html",
		controller: "historyController"
	})
	.when('/about', {
		templateUrl: "app/view/about.html",
		controller: "homeController"
	});
});