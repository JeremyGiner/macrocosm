package client.controller;
import js.Browser;
import js.html.DOMElement;
import js.html.Event;
import js.html.InputElement;
import js.html.XMLHttpRequest;
import haxe.Json;
import unveil.controller.PageController;

/**
 * ...
 * @author 
 */
class Signin {

	var _oPageController :PageController;
	
	public function new( oPageController :PageController ) {
		_oPageController = oPageController;
		Browser.document.addEventListener( 'submit', handleEvent );
	}
	
	public function handleEvent( event :Event ) {
		
		// Handle link click
		// TODO : make sure to have the least priority on click event
		// TODO : handle form
		var oTarget :DOMElement = cast event.originalTarget;
		if ( 
			!Std.is( oTarget, DOMElement ) 
			|| oTarget.id != 'form_home_signin'
		)
			return;
			
		event.preventDefault();
		// TODO : Filter : uri#id
		
		process( cast oTarget );
		//trace(js.Browser.location);
    }
	
	public function process( oForm :js.html.FormElement ) {
		
		var sLogin :String = null;
		var sPassword :String = null;
		for ( i in  0...oForm.length ) {
			var oElement :InputElement = cast oForm[i];
			if ( oElement.name == 'login' ) sLogin = oElement.value;
			if ( oElement.name == 'password' ) sPassword = oElement.value;
		}
		
		if ( sLogin == null || sPassword == null ) {// TODO : use password and login validator
			//TODO : print user message in view
			Browser.alert( 'invalid form' );
			return;
		}
		
		var oReq = new XMLHttpRequest();
		oReq.addEventListener("load", function() {
			var o = Json.parse( oReq.responseText );
			this._oPageController.goto('player'); //TODO: once email confirm implmented, goto waiting email confirm page
		});
		oReq.open(
			'POST', 
			'/_game'
		);
		oReq.setRequestHeader("Content-Type", "application/json");
		//oReq.send( Json.stringify( untyped _this.payload.innerHTML) );
		oReq.send( Json.stringify({
			procedure: "server.controller.procedure.Signin", 
			type: "unused",
			param: {
				login: sLogin,
				password: sPassword,
			},
		}) );
	}
	
}