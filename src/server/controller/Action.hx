package server.controller;
import server.controller.IAction.ActionType;
import haxe.Json;

/**
 * ...
 * @author 
 */
class Action implements IAction {

	var _sProcedure :String;
	var _oType :ActionType;
	var _oParam :Dynamic;
	
	public function new( sProcedureName :String, oType :ActionType, oParam :Dynamic ) {
		_sProcedure = sProcedureName;
		_oType = oType;
		_oParam = oParam;
	}
	
	public function getProcedureName() :String {
		return _sProcedure;
	}
	public function getType() :ActionType {
		return _oType;
	}
	public function getParam() :Dynamic {
		return _oParam;
	}
	
	static public function getFromString( s :String ) {
		var oData = Json.parse(s);
		return new Action(oData.procedure,cast( oData.type,ActionType), cast oData.param);
	}
}

