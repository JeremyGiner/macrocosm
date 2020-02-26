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
	var _iAuthLevel :Int; // 0: annonymous, 1: player, 2: admin
	
//_____________________________________________________________________________
// Constructor
	
	public function new( sEmail :String, sPassword :String, iAuthLevel :Int = 1 ) {
		_sEmail = sEmail;
		_sPasswordShadow = encode(sPassword);
		_iAuthLevel = iAuthLevel;
		_oPlayer = null;
	}
	
//_____________________________________________________________________________
// Accessor
	
	public function getEmail() {
		return _sEmail;
	}
	
	public function getPasswordShadow() {
		return _sPasswordShadow;
	}
	
	public function getLevel() {
		return _iAuthLevel;
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