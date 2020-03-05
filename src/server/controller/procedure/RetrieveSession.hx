package server.controller.procedure;
import entity.Auth;
import server.controller.Controller.AccessDenied;
import server.controller.Controller.UserMessage;



/**
 * ...
 * @author 
 */
class RetrieveSession extends AControllerProcedure<Dynamic> {
	
	override public function process( o :Dynamic ) : Dynamic {
		
		return _oController.getSession().getData();
	}
}

