extends Node

var player_gold: int
var player_health: int
var player_max_health: int
# player_soldiers är en dictionary så vi kan mappa soldat till en location
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

func on_purchase(soldier: TestSoldier):
	player_gold -= soldier.attributes.cost
	player_soldiers.append(soldier)
	print(player_gold)
