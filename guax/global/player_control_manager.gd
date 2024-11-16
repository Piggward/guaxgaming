extends Node

var dragging = false
var drag_object: Ally

func _process(delta):
	pass
		
func can_drag():
	return not dragging && TurnManager.current_phase.phase == TurnPhase.Phase.SHOPPING
	
