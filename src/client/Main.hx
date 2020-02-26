package client;
import client.controller.process.GameRequest;
import client.view.WorldmapViewBuilder;
import haxe.Json;
import haxe.ds.StringMap;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.XMLHttpRequest;
import js.lib.RegExp;
import client.response_body_decoder.ResponseBodyRibbon;
import unveil.controller.FormController;
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
						partialAr: null,
					},
				}, new WorldmapViewBuilder()),
				'user' =>  null,
				'prodtype_ar' => new LoaderXhrJson('POST', '/_game', [], {
					procedure: "server.controller.procedure.RetrieveObject", 
					type: "unused",
					param: {
						storage: '',
						id: -1,
						partialAr: null,
					},
				}, new ResponseBodyRibbon()),
			],
			[
				{
					id: 'home',
					path_pattern: new RegExp('\\/'),
					page_data: {
						hello: true,
						content: 'page content',
						array: ['item0','item1'],
					},
					model_load: ['user'],
				},
				{
					id: 'player',
					path_pattern: new RegExp('\\/player'),
					page_data: null,
					model_load: ['user'],
				},
				{
					id: 'worldmap',
					path_pattern: new RegExp('\\/worldmap'),
					page_data: null,
					model_load: ['user','worldmap'],
				},
				{
					id: 'asset',
					path_pattern: new RegExp('\\/asset'),
					page_data: null,
					model_load: ['user'],
				},
				{
					id: 'debug',
					path_pattern: new RegExp('\\/debug'),
					page_data: null,
					model_load: ['user'],
				},
				{
					id: 'asset_buy',
					path_pattern: new RegExp('\\/buy(\\/\\d+)?'),
					page_data: null,
					model_load: ['user'],
				},
				{
					id: 'not_found',
					path_pattern: new RegExp('\\/not-found'),
					page_data: null,
					model_load: ['user'],
				},
				
			], [
				{key: 'navbar', template: Resource.getString('navbar')},
				
				{key: 'worldmap_sector', template: Resource.getString('worldmap_sector')},
				{key: 'worldmap_map', template: Resource.getString('worldmap_map')},
				{key: 'worldmap', template: Resource.getString('worldmap')},
				{key: 'home_form_signin', template: Resource.getString('home_form_signin')},
				{key: 'home_form_signup', template: Resource.getString('home_form_signup')},
				{key: 'home', template: Resource.getString('home')},
				{key: 'asset', template: Resource.getString('asset')},
				{key: 'debug', template: Resource.getString('debug_ws_action')},
				{key: 'player_create_form', template: Resource.getString('player_create_form')},
				{key: 'player_create', template: Resource.getString('player_create')},
			]
		);
		
		var oPController = oUnveil.getPageController();
		new FormController( [
			'form_signout' => new GameRequest( oPController,'server.controller.procedure.Signout',null,'home'),
			'form_signin' => new GameRequest( oPController,'server.controller.procedure.Signin','user','home'),
			'form_signup' => new GameRequest( oPController,'server.controller.procedure.Signup','user','home'),
		]);
		
		//new Signin( oUnveil.getPageController() );
		//new Signup( oUnveil.getPageController() );
		
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