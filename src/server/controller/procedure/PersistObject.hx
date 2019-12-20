package server.controller.procedure;
import sweet.functor.builder.FactoryDefault;

typedef PersistEntity = {
	var entity_path :String;
	var param :Array<Dynamic>;
}


/**
 * ...
 * @author 
 */
class PersistObject extends AControllerProcedure<PersistEntity> {
	
	override public function process( o :PersistEntity ) {
		
		// TODO : deny access on * but ...
		
		var o = new FactoryDefault(Type.resolveClass( o.entity_path ), o.param).create();
		var oDatabase = _oController.getDatabase();
		oDatabase.persist( o );
		oDatabase.flush();
		return o;
	}
}