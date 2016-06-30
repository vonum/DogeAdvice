(function(){

  angular.module("dogeApp").service("historyService", historyService);
  
  function historyService() {
	  
	this.diagnosedWith = [];
	this.addDiagnosys = function(diagnosys)
	{
		if(this.diagnosedWith.indexOf(diagnosys) === -1)
		{
			this.diagnosedWith.push(diagnosys);
		}
	}

  }

})();