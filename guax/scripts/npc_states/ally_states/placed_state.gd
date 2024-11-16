class_name PlacedState
extends OutOfBattleState


func enter():
	ally.battle_start_location = ally.global_position
	ally.input_event.connect(_on_input_event)
	pass

func exit():
	ally.input_event.disconnect(_on_input_event)
	pass

func _on_input_event(event: InputEvent):
	if event.is_action_pressed("left_mouse")  && PlayerControlManager.can_drag():
		transition_requested.emit(self, OutOfBattleState.State.DRAGGING)
