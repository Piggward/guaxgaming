class_name Ally
extends Npc

var battle_start_location: Vector2
@export var cost: int
@onready var out_of_battle_state_machine = $OutOfBattleStateMachine

signal reposition(ally: Ally)

func _ready():
	aggrozone = get_tree().get_nodes_in_group("Aggrozone")[0]
	out_of_battle_state_machine.init(self)
	TurnManager.battle_turn.turn_end.connect(refresh)
	super()
	
func refresh():
	state_machine.current_state = state_machine.initial_state
	global_position = battle_start_location
	set_health(maxHealth)
