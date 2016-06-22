(function() {
	angular.module("dogeApp").controller("startController", startController);
	
	startController.$inject = ["$scope", "socketService"];
	
	function startController($scope, socketService) {
		
		ws = socketService.ws;
		
		ws.onMessage(function (event) {
			alert("STARTED AND WORKING");
		});
		
		$scope.test = function() {
			ws.send("hello");
		}
		
	}
	
})();