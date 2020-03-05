package server.controller.procedure;
import entity.Player;
import entity.Productor;
import server.controller.Controller.AccessDenied;
import server.controller.Controller.UserMessage;
import sweet.functor.builder.FactoryDefault;
import entity.ProductorType;
import entity.Location;

typedef BuyProductorParam = {
	var type_id :Int;
	var param :Array<Dynamic>;
	var locationAr :Array<String>;
}


/**
 * ...
 * @author 
 */
class BuyProductor extends AControllerProcedure<BuyProductorParam> {
	
	override public function process( o :BuyProductorParam ) :Dynamic {
		
		if ( !checkAccess() )
			return new AccessDenied('Require authentification');
		
		
		// Get location array 
		var aLocation = o.locationAr.map(function( s :String ) {
			return Location.fromString( s );
		});
		
		
		var oDatabase = _oController.getDatabase();
		
		// Get player
		var iPlayerId = _oController.getSession().getData().player_id;
		if ( iPlayerId == null ) 
			return new AccessDenied('');
		var oPlayer :Player = oDatabase.mustGet('Default', iPlayerId);
		
		// Get productor type
		var oProductorType :ProductorType = cast oDatabase.get('Default', o.type_id );
		if ( oProductorType == null || !Std.is(oProductorType,ProductorType) ) 
			return new UserMessage('Invalid productor type id : #'+);
		
		// Check player credit/contract
		var iCredit = oPlayer.getDynasty().getCredit();
		var iCost = oProductorType.getBaseCost();
		if ( iCredit > iCost )
			return new UserMessage('Not enought credit');
		if ( oPlayer.getDynasty().getAvailableContract() <= 0 )
			return new UserMessage('Not enought contract');
		
		oPlayer.getDynasty().addCredit( -iCost );
		
		// TODO : update contract count (using event)
		var o = new Productor('', oPlayer.getDynasty(), aLocation, oProductorType );
		//var o = new FactoryDefault(Type.resolveClass( o.entity_path ), o.param).create();
		oDatabase.persist( o );
		oDatabase.flush();
		return o;
	}
	
	
	public function checkAccess() {
		var oSessionData = _oController.getSession().getData();
		if ( oSessionData == null )
			return false;
		
		//TODO : check session.auth != null
		if ( oSessionData.auth_level < 1 )
			return false;
		
		return true;
	}
}