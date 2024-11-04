extends Node

var player_gold: int
var player_health: int
var player_max_health: int
var player_soldiers: Array[TestSoldier]

signal soldier_purchased(soldier: TestSoldier)

# Called when the node enters the scene tree for the first time.
func _ready():
	soldier_purchased.connect(on_purchase)
	player_gold = 5000
	player_health = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func can_purchase(soldier: TestSoldier) -> bool:
	if !PlayerControlManager.can_drag():
		print("player is busy")
		return false
		
	if soldier.attributes.cost > GameManager.player_gold:
		print("player cant afford")
		return false
		
	var c = TurnManager.current_phase.phase
		
	if TurnManager.current_phase.phase != TurnPhase.Phase.SHOPPING:
		print("Not in shop phase")
		return false
	
	return true
	

func on_purchase(soldier: TestSoldier):
	player_gold -= soldier.attributes.cost
	player_soldiers.append(soldier)
	print(player_gold)
