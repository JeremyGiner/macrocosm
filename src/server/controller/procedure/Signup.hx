package server.controller.procedure;
import entity.Auth;
import sweet.functor.builder.FactoryDefault;

typedef SignupParam = {
	var login :String;
	var password :String;
}


/**
 * ...
 * @author 
 */
class Signup extends AControllerProcedure<SignupParam> {
	
	override public function process( o :SignupParam ) {
		
		// TODO : deny access on * but ...
		// TODO : constraint unique
		var oAuth = new Auth( o.login, o.password );
		var oDatabase = _oController.getDatabase();
		oDatabase.persist( oAuth );
		oDatabase.flush();
		
		// TODO: send confirmation email
		var oData = _oController.getSession().getData();
		if ( oData == null )
			oData = {auth_level: 1};
		else
			oData.auth_level = 1;
		_oController.getSession().setData( oData );
		
		
		return o;
	}
}