package server.database;
import sweet.ribbon.MappingInfoProvider;
import sweet.ribbon.RibbonMacro;
import entity.*;
import entity.worldmap.*;
import entity.part.*;
import sweet.ribbon.MappingInfo;

/**
 * ...
 * @author ...
 */
class DatabaseMappingInfoProvider extends MappingInfoProvider {

	public function new() {
		super();
		// TODO: use macro to get all entity class
		RibbonMacro.setMappingInfo( this, Auth );
		RibbonMacro.setMappingInfo( this, TileCapacityRequirement );
		RibbonMacro.setMappingInfo( this, Tile );
		RibbonMacro.setMappingInfo( this, TileCapacityOvercrowd );
		RibbonMacro.setMappingInfo( this, TileCapacityType );
		RibbonMacro.setMappingInfo( this, ProductType );
		RibbonMacro.setMappingInfo( this, Production );
		RibbonMacro.setMappingInfo( this, ProductionType );
		RibbonMacro.setMappingInfo( this, Productor );
		RibbonMacro.setMappingInfo( this, ProductorType );
		RibbonMacro.setMappingInfo( this, Worldmap );
		RibbonMacro.setMappingInfo( this, Sector );
	}
	
}