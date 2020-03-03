package server.controller;
import haxe.Json;

/**
 * ...
 * @author 
 */
class Action implements IAction {

	var _sProcedure :String;
	var _oParam :Dynamic;
	
	public function new( sProcedureName :String, oParam :Dynamic ) {
		_sProcedure = sProcedureName;
		_oParam = oParam;
	}
	
	public function getProcedureName() :String {
		return _sProcedure;
	}
	public function getParam() :Dynamic {
		return _oParam;
	}
	
	static public function getFromString( s :String ) {
		var oData = Json.parse(s);
		return new Action(oData.procedure, cast oData.param);
	}
}

