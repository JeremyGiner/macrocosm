package server.controller.procedure;
import server.controller.Controller.AccessDenied;

/**
 * ...
 * @author 
 */

 typedef DbGetIndex = {
	var storage :String;
}
 
class RetrieveIndex extends AControllerProcedure<DbGetIndex> {
	
	override public function process( o :DbGetIndex ) :Dynamic {
		
		if ( 
			_oController.getSession().getData() == null 
			|| _oController.getSession().getData().auth_level < 1 
		)
			return new AccessDenied('');
		
		var oDatabase = _oController.getDatabase();
		var o = oDatabase
			.getStorage(o.storage)
			.getDescriptor()
			.getPrimaryIndex()
		;
		return [for(key in o.keys()) key];
	}
}