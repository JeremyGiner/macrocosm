package entity.mapper;
import sweet.ribbon.MappingInfoProvider;
import sweet.ribbon.RibbonMacro;
import entity.*;
import entity.worldmap.*;
import entity.part.*;
import sweet.ribbon.MappingInfo;
import storo.StoroReference;

/**
 * ...
 * @author ...
 */
class ClientMappingInfoProvider extends MappingInfoProvider {

	public function new() {
		super();
		
		RibbonMacro.setMappingInfo( this, StoroReference );
		
		RibbonMacro.setMappingInfo( this, Auth );
		getByClass(Auth).getFieldNameAr().remove('_sPasswordShadow');
		
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