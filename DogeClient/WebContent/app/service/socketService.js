(function(){

  angular.module("dogeApp").service("socketService", socketService);

  socketService.$inject = ["$websocket"];
  
  function socketService($websocket) {
	  
	var ws = $websocket('ws://localhost:8080/DogeClient/websocket');
	
	ws.onMessage(function (event) {
		console.log('messageReceived', event);
	});
	
	ws.onError(function (event) {
		console.log('connection Error', event);
    });
    ws.onClose(function (event) {
        console.log('connection closed', event);
    });
    ws.onOpen(function () {
        console.log('connection open');
        //ws.send('hello');
    });

    return {
      ws: ws
    };

  }

})();
