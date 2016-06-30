(function() {
	angular.module("dogeApp").controller("historyController", historyController);
	
	historyController.$inject = ["$scope", "historyService"];
	
	function historyController($scope, historyService) {
		
		alert("pls");
		alert(historyService.diagnosedWith);
		$scope.diagnosedWith = historyService.diagnosedWith;
	
	}
	
})();