package server.controller;

/**
 * ...
 * @author 
 */
interface IAction {
	public function getProcedureName() :String;
	public function getType() :ActionType;
	public function getParam() :Dynamic;
	// TODO : delegate permition here ?
}


enum ActionType {
	Alias;//TODO: resolve alias
	Composite; // expect Array<IAction> in param
	
	PersistObject;
	RetrieveObject;
	RetrieveObjectList;
	DestroyObject;
	
	Process;
	
	Login;
}