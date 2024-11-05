class_name Ally
extends Npc

var battle_start_location: Vector2
@export var cost: int
	
func _on_placeholder_placed(placeholder: PlaceholderUnit):
	self.battle_start_location = placeholder.battle_position

func _ready():
	aggrozone = get_tree().get_nodes_in_group("Aggrozone")[0]
	super()
