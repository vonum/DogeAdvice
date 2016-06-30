var dogeApp = angular.module("dogeApp", ["ngRoute", "ngWebSocket"]);

dogeApp.config(function($routeProvider) {
	$routeProvider
	.when('/', {
		templateUrl: "view/home.html",
		controller: "homeController"
	})
	.when('/start', {
		templateUrl: "view/start.html",
		controller: "startController"
	})
	.when('/diagnose', {
		templateUrl: "view/diagnose.html",
		controller: "diagnoseController"
	})
	.when('/history', {
		templateUrl: "view/history.html",
		controller: "historyController"
	})
	.when('/about', {
		templateUrl: "view/about.html",
		controller: "homeController"
	});
});