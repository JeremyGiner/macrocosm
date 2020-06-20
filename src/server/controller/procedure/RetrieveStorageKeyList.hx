package server.controller.procedure;

/**
 * ...
 * @author 
 */
 
class RetrieveStorageKeyList extends AControllerProcedure<Dynamic> {
	
	override public function process( o :Dynamic ) :Dynamic {
		
		var oDatabase = _oController.getDatabase();
		var aKey = [for(key in oDatabase.getStorageList().keys()) key];
		
		return aKey;
	}
}