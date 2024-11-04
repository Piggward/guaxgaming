class_name BattleTurnPhase
extends TurnPhase

func phase_start():
	# Spawn enemy wave
	
	# Replace placeholders
	pass
	
func phase_end():
	# Remove all soldiers from the game
	# Respawn all placeholders
	TurnManager.next_turn()
	pass
	
func phase_act():
	# Check if all enemies is defeated. 
	# If they are - phase_end.
	pass
