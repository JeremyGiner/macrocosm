package server.rudy;
import haxe.CallStack;
import haxe.Json;
import haxe.io.Bytes;
import haxe.io.Path;
import rudyhh.IRequestHandler;
import rudyhh.Request;
import rudyhh.RequestReader;
import rudyhh.Response;
import server.controller.IAction;
import entity.mapper.ClientMappingInfoProvider;
import server.rudy.session.SessionManager;
import sweet.ribbon.RibbonEncoder;
import sweet.ribbon.RibbonStrategy;
import sys.FileStat;
import sys.FileSystem;
import sys.net.Socket;
import sys.thread.Thread;
import sys.io.File;
import rudyhh.tool.HttpTool;
import server.controller.Action;
import server.controller.Controller.AccessDenied;
import server.controller.Controller.SessionData;
import server.controller.Controller;

/**
 * ...
 * @author 
 */
class RequestHandler implements IRequestHandler {

	var _oParentThread :Thread;
	
	var _oController :Controller;
	var _oSessionManager :SessionManager<SessionData>;
	
	var _oEncoder :RibbonEncoder;
	
	public function new() {
		_oParentThread = Thread.current();
		_oController = new Controller();
		_oSessionManager = new SessionManager<SessionData>('temp');
		_oEncoder = new RibbonEncoder( new RibbonStrategy( new ClientMappingInfoProvider() ) );
	}
	
	public function handle( oClientSocket :Socket ) {//TODO : return child thread or something
		//Thread.create( this.main );
		main( oClientSocket );
	}
	
	public function main( oClientSocket :Socket ) {
		_oController.setConnectionInfo( oClientSocket.host() );
		
		// Read request
		var oReader = new RequestReader( oClientSocket.input );
		try {
			while (oReader.read() != State.Done ){}
		} catch ( e :Dynamic ) {
			var o = new Response(400, 'Unreadable'); // TODO: cache response?
			trace('WARNING : unreadable request');
			oClientSocket.output.write( o.toBytes() );
			oClientSocket.output.flush();
			oClientSocket.close();
			return;
		}
		var oRequest = oReader.createRequest();
		trace('dispaching request : "'+ oRequest.getUri()+'"');
		
		var oResponse :Bytes = getResponse( oRequest ).toBytes();
		
		//trace( StringTools.urlEncode("HTTP/1.1 404 Not found\r\nContent-Type: text/html\r\nContent-Length: 22\r\n\r\nSysError(Can't read /)"));
		oClientSocket.output.prepare( oResponse.length );
		oClientSocket.output.write( oResponse );
		oClientSocket.output.flush(); // doesn't pause thread as i would expect
		//Sys.sleep(1); // fix flush, doesn't work TODO fix
		oClientSocket.close();
	}
	
//_____________________________________________________________________________
// Sub routine
	
	function getResponse( oRequest :Request ) :Response {
		// Trim URI
		var sUri = oRequest.getUri();
		
		_oSessionManager.processRequest( oRequest );
			
		// DEBUG
		//trace( _oSessionManager.test() );
		//trace( _oSessionManager.getSession().getData() );
		//trace( _oSessionManager.test() );
		
		//trace(oRequest.getHeaderMap());
		
		//_____________________________
		// _res
		if ( StringTools.startsWith( sUri, '/_res/' ) ){
			var oPath = new Path(sUri.substr(1));
			var oResponse = new Response();
			oResponse.setETag( FileSystem.stat( oPath.toString() ).mtime.toString() );
			oResponse.setContent( 
				File.getBytes( oPath.toString() ), 
				HttpTool.getContentTypeByExt( Path.extension( sUri ) )
			);
			trace('NOTICE : dispaching file content : "'+oPath.toString()+'"');
			return oResponse;
		}
		
		//_____________________________
		// game action (delegate to Controller)
		if ( StringTools.startsWith( sUri, '/_game/' ) || sUri == '/_game' ) {
			if ( oRequest.getBody() == null )
				return Response.createSimple(400, 'Bad request', 'Request has no body' );
			
			//TODO : turn data into Action
			var oAction :Action;
			try {
				var oData = oRequest.getBody();
				oAction = new Action(oData.procedure, cast oData.param);
			} catch ( e :Dynamic ) {
				File.saveContent('error.log',CallStack.toString(CallStack.callStack()) + ' - ' + e);
				return Response.createSimple(400, 'Bad request', 'Expected parsable Action fomated in json ');
			}
			
			var o = _oController.process( oAction, _oSessionManager );
			if ( Std.is(o, UserMessage) ) {
				return Response.createSimple(400, 'Bad request', 'user message : '+o.getMessage());
			} else if ( Std.is(o, AccessDenied) ) {
				return Response.createSimple(403, 'Access denied', o.getMessage() );
			} else if ( Std.is(o, Error) ) {
				// TODO : log message
				trace(o.getCallstack() + ' - ' + o.getMessage());
				return Response.createSimple(500, 'Server internal error');
			}
			
			
			//WIP
			var oResponse =  new Response( 200, 'OK');
			var oBytes = _oEncoder.encode( o );
			oResponse.setContent( oBytes, 'application/octet-stream' );
			
			//var oResponse = new Response( 200, 'OK', Json.stringify( o ) );
			//oResponse.setHeader('Content-Type', 'application/json');
			_oSessionManager.processResponse(oResponse);
			return oResponse;
		}
		
		//_____________________________
		// index 
		var oPath = new Path('index.html');
		var oResponse = new Response();
		oResponse.setETag( FileSystem.stat( oPath.toString() ).mtime.toString() );
		oResponse.setContent( 
			File.getBytes( oPath.toString() )
		);
		return oResponse;
		
	}
}