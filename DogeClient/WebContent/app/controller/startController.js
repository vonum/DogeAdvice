(function() {
	angular.module("dogeApp").controller("startController", startController);
	
	startController.$inject = ["$scope", "$location", "socketService"];
	
	function startController($scope, $location, socketService) {

		ws = socketService.ws;
		
		/*ws.onMessage(function (event) {
			alert(event.data);
		});*/
		
		$scope.init = function(category) {
			ws.send("init:" + category);
			$location.path("/diagnose")
		}
		
	}
	
})();