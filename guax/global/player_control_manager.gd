extends Node

var dragging = false

func _process(delta):
	pass
		
func can_drag():
	return not dragging && TurnManager.current_phase.phase == TurnPhase.Phase.SHOPPING
	
