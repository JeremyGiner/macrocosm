package server.controller.procedure;

/**
 * ...
 * @author ...
 */
class Signout extends AControllerProcedure<Dynamic> {

	override public function process( o :Dynamic ) :Dynamic {
		_oController.getSession().setData(null);
		return null;
	}
	
}