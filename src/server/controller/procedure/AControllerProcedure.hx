package server.controller.procedure;
import rudyhh.Response;
import server.controller.Controller;

/**
 * ...
 * @author 
 */
class AControllerProcedure<CParam> {
	
	var _oController :Controller;
	
	public function new( oController :Controller ) {
		_oController = oController;
	}
	
	public function getId() {
		return Type.getClassName( Type.getClass(this) );// TODO : use macro
	}
	
	public function getController() {
		return _oController;
	}
	
	public function process( oParam :CParam ) :Dynamic {
		throw 'override me';
		return null;
	}

}
