class_name PlacedState
extends OutOfBattleState


func enter():
	ally.battle_start_location = ally.global_position
	#ally.connect("../OutOfBattleStateinput_event", _on_input_event)
	pass

func exit():
	#ally.disconnect("input_event", _on_input_event)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_control_gui_input(event):
	if event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, OutOfBattleState.State.DRAGGING)
	pass # Replace with function body.
