class_name Ally
extends Npc

@export var cost: int
	
func _ready():
	aggrozone = get_tree().get_nodes_in_group("Aggrozone")[0]
	super()
