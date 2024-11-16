class_name Npc_State_Machine
extends Node

@export var initial_state: NpcState
var current_state: NpcState
var states := {};

func init(npc:Npc) -> void:
	npc.on_death.connect(on_npc_death)
	TurnManager.battle_turn.turn_end.connect(_on_turn_end)
	for child in get_children(): 
		if child is NpcState: 
			states[child.state] = child;
			child.transition_requested.connect(_on_transition_requested)
			child.npc = npc
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func act():
	current_state.act()

func _on_transition_requested(from: NpcState, to: NpcState.State) -> void:
	if from != current_state:
		return
	var new_state: NpcState = states[to]
	if not new_state:
		return

	if current_state:
		current_state.exit()
	new_state.target = current_state.target
	new_state.enter()
	current_state = new_state
	
func on_npc_death(npc: Npc):
	_on_transition_requested(current_state, NpcState.State.DEAD)

func _on_turn_end():
	_on_transition_requested(current_state, NpcState.State.IDLE)
