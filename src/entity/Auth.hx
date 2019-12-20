package entity;

/**
 * Special entity used to handle restricted access content
 * @author GINER Jeremy
 */
class Auth {

	var _oPlayer :Player;
	var _sEmail :String;	// prime index
	var _sPasswordShadow :String;
	var _bValidated :Bool;
	
	public function new( sEmail :String, sPassword :String ) {
		_sEmail = sEmail;
		_sPasswordShadow = encode(sPassword);
		_bValidated = false;
		_oPlayer = null;
	}
	
	public function getEmail() {
		return _sEmail;
	}
	
	public function getPasswordShadow() {
		return _sPasswordShadow;
	}
	
	public function getPlayer() {
		return _oPlayer;
	}
	
	static public function encode( s :String ) {
		//TODO : use salt
		return Crypto.encrypt( s );
	}
}