package client.controller.process;
import js.Browser;
import js.html.TextDecoder;
import sweet.functor.IFunction;
import sweet.functor.IProcedure;
import js.html.FormElement;
import haxe.Json;
import js.html.XMLHttpRequest;
import unveil.controller.FormController;
import unveil.controller.PageController;
import client.response_body_decoder.ResponseBodyRibbon;
import js.html.XMLHttpRequestResponseType;

/**
 * ...
 * @author ...
 */
class GameRequest implements IFunction<FormElement,Dynamic> {
	
	var _sProcedure :String;
	var _oPageController :PageController;
	var _sModelKey :String;
	var _sPath :String;
	
	public function new( 
		oPageController :PageController, 
		sProcedure :String, 
		sModelKey :String,
		sPath :String
	) {
		_sProcedure = sProcedure;
		_oPageController = oPageController;
		_sModelKey = sModelKey;
		_sPath = sPath;
	}
	
	public function apply( oForm :FormElement ) {
		var oReq = new XMLHttpRequest();
		oReq.responseType = XMLHttpRequestResponseType.ARRAYBUFFER;
		oReq.addEventListener("load", function() {
			
			switch( oReq.status ) {
				case 200 : 
					// TODO : handle response status != 200
					if( _sModelKey != null )
						_oPageController.getModel().setEntity( 
							_sModelKey, 
							ResponseBodyRibbon.singleton().apply(oReq) 
						);
					
					_oPageController.goto(_sPath); //TODO: once email confirm implmented, goto waiting email confirm page
				default:
					var o = new TextDecoder();
					Browser.alert(o.decode(oReq.response));
					return;
			}
			
			
		});
		oReq.open(
			'POST', 
			'/_game'
		);
		oReq.setRequestHeader("Content-Type", "application/json");
		//oReq.send( Json.stringify( untyped _this.payload.innerHTML) );
		oReq.send( Json.stringify( getRequestData( oForm ) ) );
		return oReq;
	}
	
	public function getRequestData( oForm :FormElement ) :Dynamic {
		return {
			procedure: _sProcedure, 
			type: "unused",
			param: FormController.getInputMap( oForm ),
		}
	}
}