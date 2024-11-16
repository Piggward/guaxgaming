class_name BattleTurnPhase
extends TurnPhase

func phase_start():
	print_debug("battle start")
	turn_start.emit()	
	pass
	
func phase_end():
	print_debug("battle end")
	turn_end.emit()
	
	TurnManager.next_turn()
	pass
	
func phase_act():
	# Check if all enemies is defeated. 
	# If they are - phase_end.
	pass
