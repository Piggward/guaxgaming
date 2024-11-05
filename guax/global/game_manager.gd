extends Node

var player_gold: int
var player_health: int
var player_max_health: int
var player_allies: Array[Ally]
var level: Level

signal soldier_purchased(soldier: Ally)

# Called when the node enters the scene tree for the first time.
func _ready():
	soldier_purchased.connect(on_purchase)
	player_gold = 5000
	player_health = 100
	pass # Replace with function body.

func spawn_enemy_wave():
	level.spawn_next_wave()

func spawn_soldiers():
	for ally in player_allies:
		# If parent is null it means that we have never added this npc to the scene tree before.
		if ally.get_parent() == null:
			level.spawn_soldier(ally)
		# Otherwise, it is in the scene tree and we just need to set the position and visibility.
		else:
			ally.global_position = ally.battle_start_location
			ally.visible = true
		
func replace_soldiers():
	for npc in player_allies:
		npc.visible = false

func can_purchase(soldier: Ally) -> bool:
	if !PlayerControlManager.can_drag():
		print("player is busy")
		return false
		
	if soldier.cost > GameManager.player_gold:
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
