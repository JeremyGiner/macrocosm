package server.controller.procedure;
import entity.WorldFactory;

/**
 * ...
 * @author 
 */

 
class InitWorld extends AControllerProcedure<Dynamic> {
	
	override public function process( o :Dynamic ) {
		
		
		
		var o = new WorldFactory();
		var a = o.create();
		
		var oDatabase = _oController.getDatabase();
		
		for ( oEntity in Lambda.flatten( a ) ) {
			oDatabase.persist( oEntity );
		}
		oDatabase.flush();
		return null;
	}
}