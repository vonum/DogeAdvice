(function() {
	angular.module("dogeApp").controller("historyController", historyController);
	
	historyController.$inject = ["$scope", "historyService"];
	
	function historyController($scope, historyService) {

		$scope.diagnosedWith = historyService.diagnosedWith;
	
	}
	
})();