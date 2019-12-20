package entity;
import entity.part.TileCapacityRequirement;
import entity.TileCapacityType;
import haxe.ds.IntMap;
import haxe.ds.StringMap;

/**
 * ...
 * @author GINER Jeremy
 */
class WorldFactory {

	
	
	public function new() {
		
	}
	
	public function create() :StringMap<Iterable<Dynamic>> {
		var a :Array<Dynamic>;
		
		new Worldmap();// TODO : use WorldmapGenerator
		
		var mTileCapacityType :IntMap<TileCapacityType> = [
			1 => new TileCapacityType('grassland'), // 33
			2 => new TileCapacityType('forest'), // 34
			3 => new TileCapacityType('fish deposit'), // 35
			4 => new TileCapacityType('crustacean deposit'), // 36
			5 => new TileCapacityType('stone deposit'), // 37
			6 => new TileCapacityType('iron deposit'), // 44
			7 => new TileCapacityType('gold deposit'), // 45
		];
		
		var mProductType = [
Product.credit => new ProductType('Credit(sell/buy)',1,''),
Product.wheat => new ProductType('wheat',1,''),
Product.floor => new ProductType('floor',2,''),
Product.wood => new ProductType('wood',1,''),
Product.wood_plank => new ProductType('wood plank',2,''),
Product.wool => new ProductType('wool',1,''),
Product.cloth => new ProductType('cloth',1,''),
Product.iron_ore => new ProductType('iron ore',1,''),
Product.iron_bar => new ProductType('iron bar',1,''),
Product.gold_ore => new ProductType('gold ore',5,''),
Product.gold_bar => new ProductType('gold bar',10,''),
Product.stone => new ProductType('stone',1,''),//!!!
Product.paper => new ProductType('paper',1,''),
Product.medecinal_herb => new ProductType('medecinal herb',1,''),
Product.bread => new ProductType('bread',4,''),
Product.meat => new ProductType('meat',1,''),
Product.fish => new ProductType('fish',1,''),
Product.fruit => new ProductType('fruit',1,''),
Product.vegetable => new ProductType('vegetable',1,''),
Product.crustaceans => new ProductType('crustaceans',1,''),
Product.tool => new ProductType('tool',1,''),
Product.outfit => new ProductType('outfit',1,''),
Product.medicine => new ProductType('medicine',1,''),
Product.housing => new ProductType('housing',1,''),
Product.furniture => new ProductType('furniture',1,''),
Product.horse => new ProductType('horse',1,''),
Product.soap => new ProductType('soap',1,''),
Product.honey => new ProductType('honey',1,''),
Product.book => new ProductType('book',1,''),
Product.toy => new ProductType('toy',1,''),
Product.delicacy => new ProductType('delicacy',1,''),
Product.painting => new ProductType('painting',1,''),
Product.jewelry => new ProductType('jewelry',1,''),
Product.watch => new ProductType('watch',1,''),
Product.crate => new ProductType('crate',1,''),
Product.weapon => new ProductType('weapon',1,''),
Product.manual_labor => new ProductType('manual labor',0,''),
		];
		
		
		var aProductionType = [
5 => new ProductionType( 'tool', [
	mProductType.get(Product.wood),
	mProductType.get(Product.iron_bar)
], [1, 1], mProductType.get(Product.tool) ),
/*
7 => new ProductionType( 'whet to floor', mProductType.get(3), [] ),
8 => new ProductionType( 'floor to bread', mProductType.get(100), [] ),
9 => new ProductionType( 'transport: pinewood', mProductType.get(4), [] ),
10 => new ProductionType( 'iron deposit to ore', mProductType.get(8), [] ),
11 => new ProductionType( 'iron ore to bar', mProductType.get(9), [] ),
101 => new ProductionType( 'transport: pinewood plank', mProductType.get(5), [] ),
102 => new ProductionType( 'transport: wheat', mProductType.get(2), [] ),
103 => new ProductionType( 'transport: floor', mProductType.get(3), [] ),
104 => new ProductionType( 'transport: bread', mProductType.get(100), [] ),
140 => new ProductionType( 'stone', mProductType.get(12), [] ),
200 => new ProductionType( 'sell: pinewood', mProductType.get(1), [] ),
201 => new ProductionType( 'sell: plank', mProductType.get(1), [] ),
202 => new ProductionType( 'sell: wheat', mProductType.get(1), [] ),
203 => new ProductionType( 'sell: floor', mProductType.get(1), [] ),
204 => new ProductionType( 'sell: bread', mProductType.get(1), [] ),
300 => new ProductionType( 'buy: wood', mProductType.get(4), [] ),
301 => new ProductionType( 'buy: plank', mProductType.get(5), [] ),
302 => new ProductionType( 'buy: wheat', mProductType.get(2), [] ),
303 => new ProductionType( 'buy: floor', mProductType.get(3), [] ),
490 => new ProductionType( 'field to wheat', mProductType.get(2), [] ),
1002 => new ProductionType( 'produce: wheat', mProductType.get(2), [] ),
1003 => new ProductionType( 'produce: floor', mProductType.get(3), [] ),
1006 => new ProductionType( 'produce: wool', mProductType.get(6), [] ),
1007 => new ProductionType( 'produce: cloth', mProductType.get(7), [] ),
1008 => new ProductionType( 'produce: iron ore', mProductType.get(8), [] ),
1009 => new ProductionType( 'produce: iron bar', mProductType.get(9), [] ),
1010 => new ProductionType( 'produce: gold ore', mProductType.get(10), [] ),
1011 => new ProductionType( 'produce: gold bar', mProductType.get(11), [] ),
1012 => new ProductionType( 'produce: stone', mProductType.get(12), [] ),
1013 => new ProductionType( 'produce: paper', mProductType.get(13), [] ),
1014 => new ProductionType( 'produce: medecinal herb', mProductType.get(14), [] ),
1100 => new ProductionType( 'produce: bread', mProductType.get(100), [] ),
1101 => new ProductionType( 'produce: meat', mProductType.get(101), [] ),
1102 => new ProductionType( 'produce: fish', mProductType.get(102), [] ),
//1103 => ,
//1104 => ,
1105 => new ProductionType( 'produce: crustaceans', mProductType.get(105), [] ),
1110 => new ProductionType( 'produce: tool', mProductType.get(110), [] ),
1111 => new ProductionType( 'produce: outfit', mProductType.get(111), [] ),
1112 => new ProductionType( 'produce: medicine', mProductType.get(112), [] ),
1113 => new ProductionType( 'produce: housing', mProductType.get(113), [] ),
1115 => new ProductionType( 'produce: furniture', mProductType.get(115), [] ),
1116 => new ProductionType( 'produce: horse', mProductType.get(116), [] ),
1120 => new ProductionType( 'produce: soap', mProductType.get(120), [] ),
1121 => new ProductionType( 'produce: honey', mProductType.get(121), [] ),
1122 => new ProductionType( 'produce: book', mProductType.get(122), [] ),
1123 => new ProductionType( 'produce: toy', mProductType.get(123), [] ),
1130 => new ProductionType( 'produce: delicacy', mProductType.get(130), [] ),
1131 => new ProductionType( 'produce: painting', mProductType.get(131), [] ),
1132 => new ProductionType( 'produce: jewelry', mProductType.get(132), [] ),
1133 => new ProductionType( 'produce: watch', mProductType.get(133), [] ),
1140 => new ProductionType( 'produce: crate', mProductType.get(140), [] ),
1141 => new ProductionType( 'produce: weapon', mProductType.get(141), [] ),
2002 => new ProductionType( 'sell: wheat', mProductType.get(1), [] ),
2003 => new ProductionType( 'sell: floor', mProductType.get(1), [] ),
2004 => new ProductionType( 'sell: wood', mProductType.get(1), [] ),
2005 => new ProductionType( 'sell: wood plank', mProductType.get(1), [] ),
2006 => new ProductionType( 'sell: wool', mProductType.get(1), [] ),
2007 => new ProductionType( 'sell: cloth', mProductType.get(1), [] ),
2008 => new ProductionType( 'sell: iron ore', mProductType.get(1), [] ),
2009 => new ProductionType( 'sell: iron bar', mProductType.get(1), [] ),
2010 => new ProductionType( 'sell: gold ore', mProductType.get(1), [] ),
2011 => new ProductionType( 'sell: gold bar', mProductType.get(1), [] ),
2012 => new ProductionType( 'sell: stone', mProductType.get(1), [] ),
2013 => new ProductionType( 'sell: paper', mProductType.get(1), [] ),
2014 => new ProductionType( 'sell: medecinal herb', mProductType.get(1), [] ),
2033 => new ProductionType( 'sell: field', mProductType.get(1), [] ),
2034 => new ProductionType( 'sell: forest', mProductType.get(1), [] ),
2100 => new ProductionType( 'sell: bread', mProductType.get(1), [] ),
2101 => new ProductionType( 'sell: meat', mProductType.get(1), [] ),
2102 => new ProductionType( 'sell: fish', mProductType.get(1), [] ),
//2103 => ,
2104 => new ProductionType( 'sell: vegetable', mProductType.get(1), [] ),
2105 => new ProductionType( 'sell: crustaceans', mProductType.get(1), [] ),
2110 => new ProductionType( 'sell: tool', mProductType.get(1), [] ),
2111 => new ProductionType( 'sell: outfit', mProductType.get(1), [] ),
2112 => new ProductionType( 'sell: medicine', mProductType.get(1), [] ),
2113 => new ProductionType( 'sell: housing', mProductType.get(1), [] ),
2115 => new ProductionType( 'sell: furniture', mProductType.get(1), [] ),
2116 => new ProductionType( 'sell: horse', mProductType.get(1), [] ),
2120 => new ProductionType( 'sell: soap', mProductType.get(1), [] ),
2121 => new ProductionType( 'sell: honey', mProductType.get(1), [] ),
2122 => new ProductionType( 'sell: book', mProductType.get(1), [] ),
2123 => new ProductionType( 'sell: toy', mProductType.get(1), [] ),
2130 => new ProductionType( 'sell: delicacy', mProductType.get(1), [] ),
2131 => new ProductionType( 'sell: painting', mProductType.get(1), [] ),
2132 => new ProductionType( 'sell: jewelry', mProductType.get(1), [] ),
2133 => new ProductionType( 'sell: watch', mProductType.get(1), [] ),
2140 => new ProductionType( 'sell: crate', mProductType.get(1), [] ),
2141 => new ProductionType( 'sell: weapon', mProductType.get(1), [] ),
3002 => new ProductionType( 'buy: wheat', mProductType.get(2), [] ),
3003 => new ProductionType( 'buy: floor', mProductType.get(3), [] ),
3004 => new ProductionType( 'buy: wood', mProductType.get(4), [] ),
3005 => new ProductionType( 'buy: wood plank', mProductType.get(5), [] ),
3006 => new ProductionType( 'buy: wool', mProductType.get(6), [] ),
3007 => new ProductionType( 'buy: cloth', mProductType.get(7), [] ),
3008 => new ProductionType( 'buy: iron ore', mProductType.get(8), [] ),
3009 => new ProductionType( 'buy: iron bar', mProductType.get(9), [] ),
3010 => new ProductionType( 'buy: gold ore', mProductType.get(10), [] ),
3011 => new ProductionType( 'buy: gold bar', mProductType.get(11), [] ),
3012 => new ProductionType( 'buy: stone', mProductType.get(12), [] ),
3013 => new ProductionType( 'buy: paper', mProductType.get(13), [] ),
3014 => new ProductionType( 'buy: medecinal herb', mProductType.get(14), [] ),
3100 => new ProductionType( 'buy: bread', mProductType.get(100), [] ),
3101 => new ProductionType( 'buy: meat', mProductType.get(101), [] ),
3102 => new ProductionType( 'buy: fish', mProductType.get(102), [] ),
3103 => new ProductionType( 'buy: fruit', mProductType.get(103), [] ),
3104 => new ProductionType( 'buy: vegetable', mProductType.get(104), [] ),
3105 => new ProductionType( 'buy: crustaceans', mProductType.get(105), [] ),
3110 => new ProductionType( 'buy: tool', mProductType.get(110), [] ),
3111 => new ProductionType( 'buy: outfit', mProductType.get(111), [] ),
3112 => new ProductionType( 'buy: medicine', mProductType.get(112), [] ),
3113 => new ProductionType( 'buy: housing', mProductType.get(113), [] ),
3115 => new ProductionType( 'buy: furniture', mProductType.get(115), [] ),
3116 => new ProductionType( 'buy: horse', mProductType.get(116), [] ),
3120 => new ProductionType( 'buy: soap', mProductType.get(120), [] ),
3121 => new ProductionType( 'buy: honey', mProductType.get(121), [] ),
3122 => new ProductionType( 'buy: book', mProductType.get(122), [] ),
3123 => new ProductionType( 'buy: toy', mProductType.get(123), [] ),
3130 => new ProductionType( 'buy: delicacy', mProductType.get(130), [] ),
3131 => new ProductionType( 'buy: painting', mProductType.get(131), [] ),
3132 => new ProductionType( 'buy: jewelry', mProductType.get(132), [] ),
3133 => new ProductionType( 'buy: watch', mProductType.get(133), [] ),
3140 => new ProductionType( 'buy: crate', mProductType.get(140), [] ),
3141 => new ProductionType( 'buy: weapon', mProductType.get(141), [] ),
3500 => new ProductionType( 'buy: manual labor', mProductType.get(500), [] ),
*/
		];
		
		var a = [
ProductionType.createTransporter( 'transport: wheat', mProductType.get(Product.wheat) ),
ProductionType.createTransporter( 'transport: floor', mProductType.get(Product.floor) ),
ProductionType.createTransporter( 'transport: wood', mProductType.get(Product.wood) ),
ProductionType.createTransporter( 'transport: wood plank', mProductType.get(Product.wood_plank) ),
ProductionType.createTransporter( 'transport: wool', mProductType.get(Product.wool) ),
ProductionType.createTransporter( 'transport: cloth', mProductType.get(Product.cloth) ),
ProductionType.createTransporter( 'transport: iron ore', mProductType.get(Product.iron_ore) ),
ProductionType.createTransporter( 'transport: iron bar', mProductType.get(Product.iron_bar) ),
ProductionType.createTransporter( 'transport: gold ore', mProductType.get(Product.gold_ore) ),
ProductionType.createTransporter( 'transport: gold bar', mProductType.get(Product.gold_bar) ),
ProductionType.createTransporter( 'transport: stone', mProductType.get(Product.stone) ),
ProductionType.createTransporter( 'transport: paper', mProductType.get(Product.paper) ),
ProductionType.createTransporter( 'transport: medecinal herb', mProductType.get(Product.medecinal_herb) ),
ProductionType.createTransporter( 'transport: bread', mProductType.get(Product.bread) ),
ProductionType.createTransporter( 'transport: meat', mProductType.get(Product.meat) ),
ProductionType.createTransporter( 'transport: fish', mProductType.get(Product.fish) ),
ProductionType.createTransporter( 'transport: fruit', mProductType.get(Product.fruit) ),
ProductionType.createTransporter( 'transport: vegetable', mProductType.get(Product.vegetable) ),
ProductionType.createTransporter( 'transport: crustaceans', mProductType.get(Product.crustaceans) ),
ProductionType.createTransporter( 'transport: tool', mProductType.get(Product.tool) ),
ProductionType.createTransporter( 'transport: outfit', mProductType.get(Product.outfit) ),
ProductionType.createTransporter( 'transport: medicine', mProductType.get(Product.medicine) ),
ProductionType.createTransporter( 'transport: housing', mProductType.get(Product.housing) ),
ProductionType.createTransporter( 'transport: furniture', mProductType.get(Product.furniture) ),
ProductionType.createTransporter( 'transport: horse', mProductType.get(Product.horse) ),
ProductionType.createTransporter( 'transport: soap', mProductType.get(Product.soap) ),
ProductionType.createTransporter( 'transport: honey', mProductType.get(Product.honey) ),
ProductionType.createTransporter( 'transport: book', mProductType.get(Product.book) ),
ProductionType.createTransporter( 'transport: toy', mProductType.get(Product.toy) ),
ProductionType.createTransporter( 'transport: delicacy', mProductType.get(Product.delicacy) ),
ProductionType.createTransporter( 'transport: painting', mProductType.get(Product.painting) ),
ProductionType.createTransporter( 'transport: jewelry', mProductType.get(Product.jewelry) ),
ProductionType.createTransporter( 'transport: watch', mProductType.get(Product.watch) ),
ProductionType.createTransporter( 'transport: crate', mProductType.get(Product.crate) ),
ProductionType.createTransporter( 'transport: weapon', mProductType.get(Product.weapon) ),
	
];
		
		var aTransporterProdcutionType = new ArrayStorableHolder<ProductionType>();
		for( o in a )
			aTransporterProdcutionType.getArray().push( o );
		
//_____________________________________
		var aProductorType = [

new ProductorType(1, 'farm', 100, 1, 'Produce wheats, honey, fruits and vegetables', 
	[
		ProductionType.createCollector( 'produce: wheat', mProductType.get(Product.wheat) ),
		ProductionType.createCollector( 'produce: fruit', mProductType.get(Product.fruit) ),
		ProductionType.createCollector( 'produce: vegetable', mProductType.get(Product.vegetable) ),
	],
	new TileCapacityRequirement( [mTileCapacityType.get(1)] )
),
new ProductorType(1, 'wood cutter', 100, 1, 'Produce wood log', 
	
	new TileCapacityRequirement( [mTileCapacityType.get(2)] )
),
new ProductorType(1, 'mine', 100, 1, 'Produce iron and gold', 
	[
		ProductionType.createCollector( 'produce: iron ore', mProductType.get(Product.iron_ore) ),
		ProductionType.createCollector( 'produce: gold ore', mProductType.get(Product.gold_ore) ),
	], new TileCapacityRequirement( [
		mTileCapacityType.get(6), 
		mTileCapacityType.get(7)
	])
),
new ProductorType(1, 'quarry', 1000000000, 1, 'Produce stone', 
	[ ProductionType.createCollector( 'produce: stone', mProductType.get(Product.stone) ) ], 
	new TileCapacityRequirement( [mTileCapacityType.get(5)] )
),
new ProductorType(1, 'hunting camp', 100, 1, 'Produce meat', 
	[ ProductionType.createCollector( 'produce: meat', mProductType.get(Product.meat) ) ],
	new TileCapacityRequirement( [mTileCapacityType.get(2)] )
),
/*new ProductorType(1, 'fishing boat', 100, 1, 'Produce fish and crustacean', [
	[ 
		//ProductionType.createCollector( 'produce: fish', mProductType.get(Product.fish) ),
		//ProductionType.createCollector( 'produce: crustacean', mProductType.get(Product.crustaceans) ),
	],
	new TileCapacityRequirement( [
		mTileCapacityType.get(3),
		mTileCapacityType.get(4),
	] )
]),*/
new ProductorType(1, 'herb collector', 1000000000, 1, 'collect herb for medecinal purposes', [
	aProductionType.get(1014),	
]),
new ProductorType(2, 'sawmill', 100, 1, 'Produce wood plank', 
	[ProductionType.createSimple( 'produce: wood', mProductType.get(Product.wood), mProductType.get(Product.wood_plank) )]
),
new ProductorType(2, 'windmill', 100, 1, 'Produce floor',
	[ProductionType.createSimple( 'produce: floor', mProductType.get(Product.wheat), mProductType.get(Product.floor) )]
),
new ProductorType(2, 'smelter', 100, 1, 'Smelt and refine metals', 
	[
		ProductionType.createSimple( 'produce: iron bar', mProductType.get(Product.iron_ore), mProductType.get(Product.iron_bar) ),
		ProductionType.createSimple( 'produce: iron bar', mProductType.get(Product.gold_ore), mProductType.get(Product.gold_bar) )
	]
),
new ProductorType(3, 'bakery', 100, 1, 'Produce bread and delicacy',
	[
		ProductionType.createSimple( 'produce: bread', mProductType.get(Product.floor), mProductType.get(Product.bread) ),
		new ProductionType( 'produce: delicacy', [mProductType.get(Product.fruit), mProductType.get(Product.bread), mProductType.get(Product.honey)], [1,1,1], mProductType.get(Product.delicacy), 1 )
	]
),
new ProductorType(3, 'blacksmith', 100, 1, 'Produce sword', [
	ProductionType.createSimple( 'produce: weapon', mProductType.get(Product.iron_bar), mProductType.get(Product.weapon) ),
]),
new ProductorType(3, 'art workshop', 100, 1, 'Produce jewelry, painting and watch', [
	ProductionType.createSimple( 'produce: painting', mProductType.get(Product.cloth), mProductType.get(Product.painting) ),
	ProductionType.createSimple( 'produce: jewelry', mProductType.get(Product.gold_bar), mProductType.get(Product.jewelry) ),
]),
new ProductorType(3, 'stable', 100, 1, 'Produce horse', [
	ProductionType.createSimple( 'produce: wool', mProductType.get(Product.wheat), mProductType.get(Product.wool) ),
	ProductionType.createSimple( 'produce: horse', mProductType.get(Product.wheat), mProductType.get(Product.horse) ),
]),
new ProductorType(3, 'apothecary', 100, 1, 'Produce medicine and soap', [
	ProductionType.createSimple( 'produce: medecine', mProductType.get(Product.medecinal_herb), mProductType.get(Product.medicine) ),
]),
new ProductorType(3, 'tailor', 100, 1, 'Produce outfit', [
	ProductionType.createSimple( 'produce: cloth', mProductType.get(Product.wool), mProductType.get(Product.cloth) ),
	ProductionType.createSimple( 'produce: outfit', mProductType.get(Product.cloth), mProductType.get(Product.outfit) ),
]),
new ProductorType(3, 'workshop', 100, 1, 'Produce tools, books and toys', [
	new ProductionType( 'produce: tool', [mProductType.get(Product.wood), mProductType.get(Product.iron_bar)], [1,1], mProductType.get(Product.tool), 1 ),
	new ProductionType( 'produce: toy', [mProductType.get(Product.wood), mProductType.get(Product.iron_bar)], [1,1], mProductType.get(Product.toy), 1 ),
]),
new ProductorType(3, 'carpenter', 100, 1, 'Produce furniture', [
	ProductionType.createSimple( 'produce: furniture', mProductType.get(Product.wood_plank), mProductType.get(Product.furniture) ),
]),
new ProductorType(3, 'building crew', 100, 1, 'Produce housing', [
	ProductionType.createSimple( 'produce: housing', mProductType.get(Product.wood_plank), mProductType.get(Product.housing) ),
]),
new ProductorType(3, 'bookbinder', 100, 1, 'Produce book', [
	ProductionType.createSimple( 'produce: book', mProductType.get(Product.paper), mProductType.get(Product.book) ),
]),

new ProductorType(4, 'cart', 0, 1, 'A basic mean of transportation for resources.', aTransporterProdcutionType.getArray()),
new ProductorType(4, 'wagon', 100, 1, 'A four-wheeled vehicle pulled by draught animals.\r\nCan carry ressources further away than a cart.', aTransporterProdcutionType.getArray()),
new ProductorType(4, 'boat', 200, 1, 'A sailing vessel that carries ressources across sea and rivers.', aTransporterProdcutionType.getArray()),

new ProductorType(5,'traveling merchant',100,1,'A merchant able to sell and buy a wide variety of ressources in small quantity.\r\nIn addition he is also able to travel from town to town.'),
new ProductorType(5,'market stall',100,1,'A merchant able to sell end product.'),
new ProductorType(5, 'restaurant', 100, 1, 'Produce delicacy and sell food'),

new ProductorType(6,'contract : manual labor',0,0,null),
		];
		//TODO: return world
		
		return [
			'tile_capacity_type' => mTileCapacityType,
			'product_type' => mProductType,
			'production_type' => aProductionType,
			'productor_type' => aProductorType,
		];
	}
	
}


enum Product {
	credit;
	wheat;
	floor;
	wood;
	wood_plank;
	wool;
	cloth;
	iron_ore;
	iron_bar;
	gold_ore;
	gold_bar;
	stone;
	paper;
	medecinal_herb;
	bread;
	meat;
	fish;
	fruit;
	vegetable;
	crustaceans;
	tool;
	outfit;
	medicine;
	housing;
	furniture;
	horse;
	soap;
	honey;
	book;
	toy;
	delicacy;
	painting;
	jewelry;
	watch;
	crate;
	weapon;
	manual_labor;
}