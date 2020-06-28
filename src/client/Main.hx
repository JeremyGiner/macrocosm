package client;
import client.controller.process.GameRequest;
import client.view.WorldmapViewBuilder;
import haxe.Json;
import haxe.ds.StringMap;
import haxe.macro.Expr.Catch;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.XMLHttpRequest;
import js.lib.RegExp;
import client.response_body_decoder.ResponseBodyRibbon;
import sweet.functor.builder.FactoryCloner;
import unveil.loader.ALoaderCalculated;
import unveil.tool.VPathAccessor;
import unveil.controller.FormController;
import unveil.template.Compiler;
import unveil.Unveil;
import haxe.Resource;
import unveil.loader.LoaderXhrJson;
import sweet.functor.builder.IBuilder;
import unveil.Model;
import unveil.View;
import unveil.controller.PageController;
import unveil.controller.FormController;
import js.html.XMLHttpRequestResponseType;
import unveil.loader.ILoader;

/**
 * ...
 * @author 
 */
@:build(unveil.tool.Macro.buildTemplate('template'))
class Main {

	static public function main() {
		
		//__________________
		// Model
		var oModel = new Model();
		
		var mModelConfig :StringMap<ILoader<Dynamic>> = [
			'worldmap' => new LoaderXhrJson<Dynamic>('POST', '/_game', [], new FactoryCloner({
				procedure: "server.controller.procedure.RetrieveObject", 
				param: {
					storage: 'Default',
					id: -1,
					partialAr: null,
				},
			}), new WorldmapViewBuilder(), XMLHttpRequestResponseType.ARRAYBUFFER),
			'session' => new GameProcedureLoader("RetrieveSession", null),
			'user' => new StoroRefLoader( oModel, 'session', new VPathAccessor('auth') ),
			'player' => new StoroRefLoader( oModel, 'user', new VPathAccessor('_oPlayer') ),
			'prodtype_ar' => new GameProcedureLoader("RetrieveObjectArray", {
				keyAr: [],
				index_chain: untyped [
					[10/* TODO: insert dynasty_id */],
					'entity.Productor#by_owner'
				],
			}),
			
			
			// Admin
			'storage_key_list' => new GameProcedureLoader("RetrieveStorageKeyList", null),
			'entity_page' => new TestLoader( oModel ),
			'admin_entity_page' => new AdminEntityListPageView( oModel ),
		];
		for ( s => o in mModelConfig )
			oModel.setEntityLoader( s, o, false );
		
		//__________________
		// View
		var oView = new View( oModel );
		
		var oCompiler = new Compiler(oView);
		var aTemplate = [
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
			{key: 'player', template: Resource.getString('player')},
			{key: 'admin', template: Resource.getString('admin')},
			
			{key: 'not_found', template: Resource.getString('not_found')},
		];
		for ( oItem in aTemplate ) {
			oView.addTemplate( oItem.key, oCompiler.compile(oItem.template) );
		}
		
		//__________________
		// Page Controller
		var oPageController = new PageController( oModel, oView );
		var mPageHandle :Array<PageHandle> = [
			{
				id: 'home',
				path_pattern: new RegExp('^\\/$'),
				page_data: {
					hello: true,
					content: 'page content',
					array: ['item0','item1'],
				},
				model_load: ['user','player'],
			},
			{
				id: 'player',
				path_pattern: new RegExp('^\\/player$'),
				page_data: null,
				model_load: ['user','player'],
			},
			{
				id: 'worldmap',
				path_pattern: new RegExp('^\\/worldmap$'),
				page_data: null,
				model_load: ['user','player','worldmap'],
			},
			{
				id: 'asset',
				path_pattern: new RegExp('^\\/asset$'),
				page_data: null,
				model_load: ['user','player','prodtype_ar'],
			},
			{
				id: 'debug',
				path_pattern: new RegExp('^\\/debug$'),
				page_data: null,
				model_load: ['user','player'],
			},
			{
				id: 'asset_buy',
				path_pattern: new RegExp('^\\/buy(\\/\\d+)?$'),
				page_data: null,
				model_load: ['user','player'],
			},
			
			{
				id: 'admin',
				path_pattern: new RegExp('^\\/admin\\/?([^\\/]+)?$','gm'),
				page_data: null,
				model_load: ['storage_key_list','admin_entity_page'],
			},
			
			{
				id: 'not_found',
				path_pattern: new RegExp('^\\/not-found$'),
				page_data: null,
				model_load: ['user','player'],
			},
			
		];
		for ( o in mPageHandle ) oPageController.addPageHandler(o);
		try {
			oPageController.goto( Browser.location.pathname );
		} catch( e :Dynamic ) {
			trace( e );
		}
		//__________________
		// Form Controller
		new FormController( [
			'form_signout' => new GameRequest( oPageController,'server.controller.procedure.Signout',null,'/'),
			'form_signin' => new GameRequest( oPageController,'server.controller.procedure.Signin','user','/'),
			'form_signup' => new GameRequest( oPageController,'server.controller.procedure.Signup','user','/'),
			'form_player_create' => new GameRequest( oPageController,'server.controller.procedure.CreatePlayer','player','/'),
		]);

	}
	
}

class GameProcedureLoader extends LoaderXhrJson<Dynamic> {
	
	public function new( procedure :String, oParam :Dynamic ) {
		super('POST', '/_game', [], new FactoryCloner({
			procedure: "server.controller.procedure."+procedure, 
			param: oParam,
		}), new ResponseBodyRibbon(), XMLHttpRequestResponseType.ARRAYBUFFER);
	}
}

class TestLoader extends LoaderXhrJson<Dynamic> {
	
	var _oModel :Model;
	
	public function new( oModel :Model ) {
		_oModel = oModel;
		super('POST', '/_game', [], null, XMLHttpRequestResponseType.ARRAYBUFFER);
	}
	
	override public function callback(resolve:String->Void, reject:Dynamic->Void) {
		var sStorage = null;
		try { sStorage = _oModel.getEntity('_route').param[0]; } catch ( e :Dynamic ){ /*ignore */}
		
		if ( sStorage == null ) {
			resolve( null );
			return;
		}
		
		super.callback( resolve, reject );
	}
	
	override public function handleResponse( oReq :XMLHttpRequest ) :Dynamic {
		var o = ResponseBodyRibbon.singleton().apply(oReq);
		return o;
	}
	
	override public function getBody() {
		
		var sStorage = null;
		var iPage = 0;
		try { sStorage = _oModel.getEntity('_route').param[0]; } catch ( e :Dynamic ){ /*ignore */}
		//try { iPage = oModel.getEntity('route').param.page; } catch ( e :Dynamic ){ /*ignore */}
		
		return Json.stringify({
			procedure: "server.controller.procedure.RetrieveStorageObjectPage", 
			param: {
				storage: sStorage,
				page: iPage,
				count: 20,
			},
		});
	}
}

class AdminEntityListPageView extends ALoaderCalculated<Dynamic> {
	public function new( oModel :Model ) {
		super(oModel,['entity_page']);
	}
	
	override public function calc(a:Array<Dynamic>):Dynamic {
		
		if ( a[0] == null )
			return null;
		
		var aRes = [];
		for ( o in cast(a[0],Array<Dynamic>) )
			aRes.push( {
				id: o.id,
				label: Type.getClassName(Type.getClass(o.data))
			} );
		return aRes;
	}
}