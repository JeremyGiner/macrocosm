package server.controller.procedure;
import entity.Auth;
import server.controller.Controller.UserMessage;
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
	
	override public function process( o :SignupParam ) :Dynamic {
		
		// TODO : deny access on * but ...
		// TODO : constraint unique
		var oAuth = new Auth( o.login, o.password );
		var oDatabase = _oController.getDatabase();
		if( 
			oDatabase
				.getStorageByObject(oAuth)
				.getDescriptor()
				.getPrimaryIndex()
				.exists( oAuth.getEmail() )
				//Assume email is primary key
		) {
			return new UserMessage(oAuth.getEmail()+' already exist');
		}
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