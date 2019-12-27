package client;
import client.controller.Signin;
import client.controller.Signup;
import haxe.Json;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.XMLHttpRequest;
import js.lib.RegExp;
import unveil.template.Compiler;
import unveil.Unveil;
import haxe.Resource;

/**
 * ...
 * @author 
 */
class Main {

	static public function main() {
		
		
		
		//TODO : create context and model
		var oUnveil = new Unveil( [
			'home' => {
				path_pattern: new RegExp('\\/'),
				page_data: {
					hello: true,
					content: 'page content',
					array: ['item0','item1'],
				}
			},
			'debug' => {
				path_pattern: new RegExp('\\/debug'),
				page_data: null,
			},
			'not_found' => {
				path_pattern: new RegExp('\\/not-found'),
				page_data: null,
			}
		], [
			'home_form_signin' => Resource.getString('home_form_signin'),
			'home_form_signup' => Resource.getString('home_form_signup'),
			'home' =>  Resource.getString('home'),
			'debug' => Resource.getString('debug_ws_action'),
		]);
		
		new Signin( oUnveil.getPageController() );
		new Signup( oUnveil.getPageController() );
		
		function reqListener ( event ) {
			Browser.console.log(event);
		}
		Browser.document.addEventListener('submit', function( event :Event ) {
			
			var _this :Element = cast event.originalTarget;
			if ( untyped _this.id != 'form-main' )
				return;
				
			event.preventDefault();
			
			
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", reqListener);
			oReq.open(
				'POST', 
				_this.getAttribute('action')
			);
			oReq.setRequestHeader("Content-Type", "application/json");
			//oReq.send( Json.stringify( untyped _this.payload.innerHTML) );
			oReq.send( untyped _this.payload.value  );
		});

	}
	
}