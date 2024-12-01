extends Node

var player_gold: int
var player_income: int
var player_health: int
var player_max_health: int
var player_allies: Array[Ally]
var level: Level

signal display_information_card(npc: Npc)
signal ally_promotion(ally: Ally, new_ally: Ally)
signal ally_purchased(ally: Ally)

signal player_gold_updated(new_gold: int)
signal player_income_updated(new_income: int)
# Called when the node enters the scene tree for the first time.
func _ready():
	ally_purchased.connect(on_ally_purchased)
	ally_promotion.connect(on_ally_promotion)
	pass # Replace with function body.

func can_purchase(cost: int) -> bool:
	return PlayerControlManager.can_drag() && can_afford(cost) && can_shop()
	
func on_ally_purchased(ally: Ally):
	transaction(ally.cost)
	player_allies.append(ally)
	
func transaction(cost: int):
	player_gold -= cost
	player_gold_updated.emit(player_gold)
	
func increase_income(increase: int):
	player_income += increase
	player_income_updated.emit(player_income)
	
func on_ally_promotion(ally: Ally, new_ally: Ally):
	# TODO: Implement transaction of rubies
	
	#Add new ally to scene
	var parent = ally.get_parent()
	parent.add_child(new_ally)
	new_ally.global_position = ally.global_position
	
	# Upgrade the new ally to the same upgrade level
	for i in new_ally.upgrade_level:
		new_ally.basic_upgrade()
		
	# Replace the old ally with the new
	parent.remove_child(ally)
	var ally_index = player_allies.find(ally)
	player_allies[ally_index] = new_ally
	ally.queue_free()
	
	ally.promoting.emit(ally, new_ally)

func can_upgrade(ally: Ally) -> bool:
	return can_shop() and can_afford(ally.upgrade.cost)
	
func can_shop() -> bool:
	return TurnManager.current_phase.phase == TurnPhase.Phase.SHOPPING
	
func can_afford(cost: int) -> bool:
	return GameManager.player_gold >= cost
