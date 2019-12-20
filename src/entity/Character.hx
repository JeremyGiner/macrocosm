package entity;
import entity.part.InGameDate;

/**
 * ...
 * @author GINER Jeremy
 */
class Character extends Pawn {
	
	// ? occupation ? workplace
	// ? personality
	// ? appearance
	
	var _sSeed :String;
	// ? seed
	// ? knowledge
	// ? acquaintance
	
	// ? expression
	// ? deck
	
	// ? State
	
	var _oBody :CharacterBody;
	
	// ? history
	
	// ? house ? status
	
	
	// ? need/wealth
	
	var _aMotivation :Array<Motivation>;
	
//_____________________________________________________________________________
// Constructor
	
	public function new( sSeed :String, oOwner :Dynasty ) {
		super('TODO:name '+sSeed, oOwner,[new Location(0,0)]);// TODO : use Orin temple spwn point
		
		_sSeed = sSeed;
		
		_oBody = new CharacterBody( _sSeed );
		
		_aMotivation = [
			Motivation.SelfPreservation,
			Motivation.RaiseChild
		];
	}
	
//_____________________________________________________________________________
// Accessor

	public function getLocationAr() {
		return _aLocation;
	}
	
	public function getBody() {
		return _oBody;
	}
	
	public function getCreated() :Null<Int> {
		return null;//TODO
	}
}

class CharacterBody {
	
	var _oSex :Sex;
	
	public function new( sSeed : String ) {
		_oSex = Math.random() > 0.5 ? Sex.Female : Sex.Male;
	}
	
	public function getSex() {
		return _oSex;
	}
}

class CharacterHistory {
	var _oType :CharacterHistoryType;
	var _oDate :InGameDate;
	
	
}

enum CharacterHistoryType {
	Wedding;
	ChildBirth;
	JobUpdate;
	Death;
}

enum Motivation {
	SelfPreservation;
	RaiseChild;
	CreateMasterPiece;
	// TODO : more
	// Care for X / self
}
enum Sex {
	Male;
	Female;
}