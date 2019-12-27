package entity;
import haxe.crypto.Sha256;

/**
 * Special entity used to handle restricted access content
 * @author GINER Jeremy
 */
class Auth {

	var _oPlayer :Player;
	var _sEmail :String;	// prime index
	var _sPasswordShadow :String;
	
	public function new( sEmail :String, sPassword :String ) {
		_sEmail = sEmail;
		_sPasswordShadow = encode(sPassword);
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
		// TODO : use BScript?
		return Sha256.encode( s );
	}
	
//_____________________________________________________________________________
// Modifier

	public function setPlayer( oPlayer :Player ) {
		_oPlayer = oPlayer;
	}
	
//_____________________________________________________________________________
// Process

	public function validatePassword( sPassword :String ) {
		return encode( sPassword ) == _sPasswordShadow;
	}
}