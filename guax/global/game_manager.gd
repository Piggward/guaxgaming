extends Node

var player_gold: int
var player_health: int
var player_max_health: int
var player_allies: Array[Ally]
var level: Level

signal display_information_card(npc: Npc)
signal ally_promotion(ally: Ally, new_ally: Ally)
signal ally_purchased(ally: Ally)
# Called when the node enters the scene tree for the first time.
func _ready():
	ally_purchased.connect(on_purchase)
	ally_promotion.connect(on_ally_promotion)
	player_gold = 5000
	player_health = 100
	pass # Replace with function body.

func can_purchase(ally: Ally) -> bool:
	if !PlayerControlManager.can_drag():
		print("player is busy")
		return false
		
	if ally.cost > GameManager.player_gold:
		print("player cant afford")
		return false
		
	if TurnManager.current_phase.phase != TurnPhase.Phase.SHOPPING:
		print("Not in shop phase")
		return false
	
	return true
	
func on_purchase(ally: Ally):
	player_gold -= ally.cost
	player_allies.append(ally)
	print(player_gold)
	
func on_ally_promotion(ally: Ally, new_ally: Ally):
	var parent = ally.get_parent()
	parent.add_child(new_ally)
	new_ally.global_position = ally.global_position
	parent.remove_child(ally)
	ally.queue_free()
	
