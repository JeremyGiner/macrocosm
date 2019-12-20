package entity;

/**
 * Calculated
 * @author GINER Jeremy
 */
class Sold {

	public function new() {
		# Get sold quantity
SELECT 
	seller.id AS pawn_id,
	city.id AS city_id,
	prodinputtype.ressource_id AS ressource_id,
	LEAST( 
		FLOOR( prodinputtype.quantity * prod.percent_max ),
		population.quantity
	) AS quantity
FROM player
JOIN pawn AS seller ON seller.player_id = player.id
JOIN prod ON prod.pawn_id = seller.id
JOIN prodtype 
	ON prodtype.id = prod.prodtype_id 
	AND prodtype.ressource_id = 1/*Credit*/
JOIN prodinput ON prodinput.prod_id = prod.id
JOIN prodinputtype ON prodinputtype.id = prodinput.prodinputtype_id
JOIN city  
	ON city.location_x = prod.location_x 
	AND city.location_y = prod.location_y
JOIN population ON population.city_id = city.id
JOIN demand 
	ON demand.city_id = city.id
	AND demand.ressource_id = prodinputtype.ressource_id
	}
	
	/**
	 * update on :
	 * - create/delete/update owned pawn with selling production with a city at it's location with a demand in sold product type
	 * - population quantity
	 * - prod.percentmax
	 */
	public function update() {
		
	}
	
}