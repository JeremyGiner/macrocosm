package server.controller.process;

/**
 * ...
 * @author ...
 */
class ProductionProcess 
{

	public function new() 
	{
		
	}
	
	//_____________________________________________________________________________
//	On Production create

	public function observeCreation( oCreated :Dynamic ) {
		
		if ( ! Std.is( oCreated, Production ) )
			return;
		
		updateRatio( oCreated );
	}

	public function updateRatio( oCreated :Dynamic ) {
		
		// ignore below, 
		// on commit, if ratio changed (check a flag) use pathfinder to iterate to each production impacted and update their ratio (assume struture to be tree and not network) 
		
		// get all prodcution
		// at output location 
		// and with input type with product type == output poduct type
		// and with same owner.owner
		var oDatabase :Database = null;
		oDatabase.getStorage('Default');
		//get list production with location == this.location using entity.Production indexed by location
		//inner join list production with product input type == output poduct type using entity.Production indexed by input product type
		//inner join list same owner.owner using Production indexed by owner.owner
		
		// persist
		oDatabase.persist( this );
	}
	
}