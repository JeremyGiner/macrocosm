package client;
import client.controller.Signin;
import client.controller.Signup;
import client.view.WorldmapViewBuilder;
import haxe.Json;
import haxe.ds.StringMap;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.XMLHttpRequest;
import js.lib.RegExp;
import unveil.template.Compiler;
import unveil.Unveil;
import haxe.Resource;
import unveil.loader.LoaderXhrJson;
import sweet.functor.builder.IBuilder;

/**
 * ...
 * @author 
 */
class Main {

	static public function main() {
		
		
		
		//TODO : create context and model
		var oUnveil = new Unveil( 
			[
				'worldmap' => new LoaderXhrJson('POST', '/_game', [], {
					procedure: "server.controller.procedure.RetrieveObject", 
					type: "unused",
					param: {
						storage: 'Default',
						id: -1,
					},
				})
			],
			[
				'home' => {
					path_pattern: new RegExp('\\/'),
					page_data: {
						hello: true,
						content: 'page content',
						array: ['item0','item1'],
					},
					model_load: null,
				},
				'worldmap' => {
					path_pattern: new RegExp('\\/worldmap'),
					page_data: null,
					model_load: ['worldmap' => new WorldmapViewBuilder()],
				},
				'debug' => {
					path_pattern: new RegExp('\\/debug'),
					page_data: null,
					model_load: null,
				},
				'not_found' => {
					path_pattern: new RegExp('\\/not-found'),
					page_data: null,
					model_load: null,
				}
			], [
				{key: 'worldmap_sector', template: Resource.getString('worldmap_sector')},
				{key: 'worldmap_map', template: Resource.getString('worldmap_map')},
				{key: 'worldmap', template: Resource.getString('worldmap')},
				{key: 'home_form_signin', template: Resource.getString('home_form_signin')},
				{key: 'home_form_signup', template: Resource.getString('home_form_signup')},
				{key: 'home', template: Resource.getString('home')},
				{key: 'asset', template: Resource.getString('asset')},
				{key: 'debug', template: Resource.getString('debug_ws_action')},
			]
		);
		
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