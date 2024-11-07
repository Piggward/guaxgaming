class_name Ally
extends Npc

var battle_start_location: Vector2
@export var cost: int
@onready var collision_shape_2d = $CollisionShape2D

func _on_placeholder_placed(placeholder: PlaceholderUnit):
	self.battle_start_location = placeholder.battle_position

func _ready():
	aggrozone = get_tree().get_nodes_in_group("Aggrozone")[0]
	super()

func die():
	on_death.emit(self)
	deactivate()
	
func refresh():
	global_position = placeholder.battle_position
	set_health(maxHealth)
	state_machine.current_state = state_machine.initial_state
