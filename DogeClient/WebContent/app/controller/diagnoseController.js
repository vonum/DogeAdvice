(function() {
	angular.module("dogeApp").controller("diagnoseController", diagnoseController);
	
	diagnoseController.$inject = ["$scope", "$websocket", "socketService"];
	
	function diagnoseController($scope, $websocket, socketService) {
		
		var ws = $websocket('ws://localhost:8080/DogeClient/websocket');
		//var ws = $websocket('ws://echo.websocket.org/');
		
		$scope.a = socketService.a;
		
		ws = socketService.ws;
		
		ws.onMessage(function (event) {
			alert(event.data);
		});
		
		/*ws.onMessage(function (event) {
			console.log('messageReceived', event);
			var parts = event.data.split(':');
			if(parts[0] === "diagnosis")
			{
				$scope.diagnosis = parts[1];
			}
			else if(parts[0] === "unlucky")
			{
				//$scope.diagnosis = "We couldn't diagnose your dog with our current knowledge base";
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
        });*/
        
        $scope.diagnosis = "";
		
		$scope.question = "Welcome to DogeApp";
        
		$scope.sendResponse = function(response)
		{
			response = response + ":" + $scope.title;
			ws.send(response);
		}
		
		$scope.facts = function()
		{
			ws.send("facts");
		}
		
	}
	
})();