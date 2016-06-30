(function() {
	angular.module("dogeApp").controller("diagnoseController", diagnoseController);
	
	diagnoseController.$inject = ["$scope", "$websocket", "socketService", "historyService"];
	
	function diagnoseController($scope, $websocket, socketService, historyService) {
		//var ws = $websocket('ws://localhost:8080/DogeClient/websocket');
		
        $scope.diagnosis = "";
		$scope.question = "Welcome to DogeApp";
		$scope.type = "";
		$scope.diagnosedWith = [];
		
		
		ws = socketService.ws;
		
		ws.onMessage(function (event) {
			console.log('messageReceived', event);
			var parts = event.data.split(':');
			if(parts[0] === "diagnosis")
			{
				$scope.diagnosis = parts[1];
				if($scope.diagnosedWith.indexOf(parts[1]) === -1)
				{
					$scope.diagnosedWith.push(parts[1]);
					historyService.addDiagnosys(parts[1]);
				}
			}
			else if(parts[0] === "noquestions")
			{
				//$scope.diagnosis = "We couldn't diagnose your dog with our current knowledge base";
			}
			else
			{
				$scope.type = parts[0];
				$scope.title = parts[1];
				$scope.question = parts[2];
			}

		});
		
		ws.send("ready");
		
		/*ws.onError(function (event) {
			console.log('connection Error', event);
        });
        ws.onClose(function (event) {
            console.log('connection closed', event);
        });
        ws.onOpen(function () {
            console.log('connection open');
            ws.send('hello');
        });*/
        
		$scope.sendResponse = function(response)
		{
			response = response + ":" + $scope.type + ":" + $scope.title;
			ws.send(response);
		}
		
		$scope.remove = function()
		{
			ws.send("remove");
		}
		
		$scope.facts = function()
		{
			ws.send("facts");
		}
		
	}
	
})();