package server.rudy;
import haxe.CallStack;
import haxe.Json;
import haxe.io.Bytes;
import haxe.io.Path;
import server.controller.Controller;
import rudyhh.IRequestHandler;
import rudyhh.Request;
import rudyhh.RequestReader;
import rudyhh.Response;
import server.controller.IAction;
import server.controller.procedure.Authentificate;
import sys.FileStat;
import sys.FileSystem;
import sys.net.Socket;
import sys.thread.Thread;
import sys.io.File;
import rudyhh.tool.HttpTool;
import server.controller.Action;
import server.controller.procedure.Authentificate.AccessDenied;
import server.controller.IAction.ActionType;

/**
 * ...
 * @author 
 */
class RequestHandler implements IRequestHandler {

	var _oParentThread :Thread;
	
	var _oController :Controller;
	
	public function new() {
		_oParentThread = Thread.current();
		_oController = new Controller();
	}
	
	public function handle( oClientSocket :Socket ) {//TODO : return child thread or something
		//Thread.create( this.main );
		main( oClientSocket );
	}
	
	public function main( oClientSocket :Socket ) {
		// Read request
		var oReader = new RequestReader( oClientSocket.input );
		while (oReader.read() != State.Done ){}
		trace('redaing done');
		var oRequest = oReader.createRequest();
		
		var oResponse = getResponse( oRequest );
		
		//trace( StringTools.urlEncode("HTTP/1.1 404 Not found\r\nContent-Type: text/html\r\nContent-Length: 22\r\n\r\nSysError(Can't read /)"));
		oClientSocket.output.writeString( oResponse.toString() );
		oClientSocket.output.flush(); // doesn't pause thread as i would expect
		Sys.sleep(1); // fix flush
		oClientSocket.close();
	}
	
//_____________________________________________________________________________
// Sub routine
	
	function getResponse( oRequest :Request ) :Response {
		// Trim URI
		var sUri = oRequest.getUri();
		
		//trace(oRequest.getHeaderMap());
		
		//_____________________________
		// _res
		if ( StringTools.startsWith( sUri, '/_res/' ) ){
			var oPath = new Path(sUri.substr(1));
			var oResponse = new Response();
			oResponse.setETag( FileSystem.stat( oPath.toString() ).mtime.toString() );
			oResponse.setContent( 
				File.getContent( oPath.toString() ), 
				HttpTool.getContentTypeByExt( Path.extension( sUri ) )
			);
			return oResponse;
		}
		
		//_____________________________
		// game action
		if ( StringTools.startsWith( sUri, '/_game/' ) ) {
			if ( oRequest.getBody() == null )
				return new Response(400, 'Bad request', 'Request has no body');
			
			//TODO : turn data into Action
			var oAction :Action;
			try {
				var oData = oRequest.getBody();
				oAction = new Action(oData.procedure,ActionType.Alias, cast oData.param);
			} catch ( e :Dynamic ) {
				File.saveContent('error.log',CallStack.toString(CallStack.callStack()) + ' - ' + e);
				return new Response(400, 'Bad request', 'Expected parsable Action fomated in json ');
			}
			
			var o = _oController.process( oAction );
			if ( Std.is(o, UserMessage) ) {
				return new Response(400, 'Bad request', 'user message : '+o.getMessage());
			} else if ( Std.is(o, AccessDenied) ) {
				return new Response(403, 'Access denied');
			} else if ( Std.is(o, Error) ) {
				// TODO : log message
				trace(o.getMessage());
				return new Response(500, 'Server internal error');
			}
			
			return new Response( 200, 'OK', Json.stringify( o ) );
		}
		
		//_____________________________
		// index 
		var oPath = new Path('index.html');
		var oResponse = new Response();
		oResponse.setETag( FileSystem.stat( oPath.toString() ).mtime.toString() );
		oResponse.setContent( 
			File.getContent( oPath.toString() )
		);
		return oResponse;
		
	}
}