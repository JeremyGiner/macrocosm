package server;
import server.rudy.RequestHandler;
import rudyhh.Server;
import haxe.Json;
import sys.io.File;

/**
 * ...
 * @author 
 */
class Main {

	static public function main() {
		
		// Get config path
		var sConfigPath = "config.json";
		if ( Sys.args().length == 1 ) {
			sConfigPath = Sys.args()[0];
		}
		
		Sys.println( 'Loading config "'+sConfigPath+'"' );
		var oConfig = Json.parse( File.getContent( sConfigPath ) );
		
		var oServer = new Server( 
			oConfig.address, 
			Std.parseInt( oConfig.port ), 
			new RequestHandler() 
		);

		Sys.println( 'Server running...' );
		while ( true ){
			oServer.process();
			//oServerSSL.process(); 
		}
	}
	
}