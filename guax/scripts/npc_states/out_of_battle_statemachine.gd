class_name OutOfBattleStateMachine
extends Node

@export var initial_state: OutOfBattleState
var current_state: OutOfBattleState
var states := {};

func init(ally: Ally) -> void:
	for child in get_children(): 
		if child is OutOfBattleState: 
			states[child.state] = child;
			child.transition_requested.connect(_on_transition_requested)
			child.ally = ally
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _on_transition_requested(from: OutOfBattleState, to: OutOfBattleState.State) -> void:
	if from != current_state:
		return
	var new_state: OutOfBattleState = states[to]
	if not new_state:
		return

	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
