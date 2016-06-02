var dogeApp = angular.module("dogeApp", ["ngRoute"]);

dogeApp.config(function($routeProvider) {
	$routeProvider
	.when('/', {
		templateUrl: "app/view/home.html",
		controller: "homeController"
	})
	.when('/choose', {
		templateUrl: "app/view/choose.html",
		controller: "homeController"
	})
	.when('/about', {
		templateUrl: "app/view/about.html",
		controller: "homeController"
	});
});