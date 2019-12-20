package server.controller;
import haxe.crypto.Sha256;

/**
 * ...
 * @author 
 */
class Auth {

	var _sLogin :String;
	var _sPasswordShadow :String;
	
	public function new( sLogin :String, sPassword :String ) {
		_sLogin = sLogin;
		_sPasswordShadow = encode(sPassword);
	}
	
	public function getLogin() {
		return _sLogin;
	}
	public function getPasswordShadow() {
		return _sPasswordShadow;
	}
	
	public function encode( s :String ) {
		return Sha256.encode( s );
	}
}