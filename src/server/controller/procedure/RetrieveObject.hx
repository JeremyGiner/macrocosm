package server.controller.procedure;

/**
 * ...
 * @author 
 */

 typedef DbGetObj = {
	var storage :String;
	var id :Int;
}
 
class RetrieveObject extends AControllerProcedure<DbGetObj> {
	
	override public function process( o :DbGetObj ) {
		
		// TODO : deny access on Auth
		var oDatabase = _oController.getDatabase();
		var o = oDatabase.get( o.storage, o.id );
		return o;
	}
}