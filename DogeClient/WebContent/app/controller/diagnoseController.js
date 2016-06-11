(function() {
	angular.module("dogeApp").controller("diagnoseController", diagnoseController);
	
	diagnoseController.$inject = ["$scope", "$websocket"];
	
	function diagnoseController($scope, $websocket) {
		
		var ws = $websocket('ws://localhost:8080/DogeClient/websocket');
		//var ws = $websocket('ws://echo.websocket.org/');
		
		ws.onMessage(function (event) {
			console.log('messageReceived', event);
			var parts = event.data.split(':');
			if(parts[0] === "diagnosis")
			{
				$scope.diagnosis = parts[1];
			}
			else
			{
				$scope.title = parts[0];
				$scope.question = parts[1];
			}
		});
		
		ws.onError(function (event) {
			console.log('connection Error', event);
        });
        ws.onClose(function (event) {
            console.log('connection closed', event);
        });
        ws.onOpen(function () {
            console.log('connection open');
            ws.send('hello');
        });
        
        $scope.diagnosis = "";
		
		$scope.question = "Welcome to DogeApp";
        
		$scope.sendResponse = function(response)
		{
			response = response + ":" + $scope.title;
			ws.send(response);
		}
		
	}
	
})();