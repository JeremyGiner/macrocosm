package server.controller.procedure;

/**
 * ...
 * @author 
 */

 typedef DbGetIndex = {
	var storage :String;
}
 
class RetrieveIndex extends AControllerProcedure<DbGetIndex> {
	
	override public function process( o :DbGetIndex ) {
		
		var oDatabase = _oController.getDatabase();
		var o = oDatabase
			.getStorage(o.storage)
			.getDescriptor()
			.getPrimaryIndex()
		;
		return [for(key in o.keys()) key];
	}
}