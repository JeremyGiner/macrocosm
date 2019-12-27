package server.rudy.session;

/**
 * ...
 * @author 
 */
interface ISessionRepository {
	public function save( oSession :Session<Dynamic> ) :Void;
    public function load( sId :Null<String> ) :Session<Dynamic>;
    public function destroy( sId :Null<String> ) :Void;
    public function exist( sId :Null<String> ) :Bool;
}
