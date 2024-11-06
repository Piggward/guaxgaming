class_name BattleTurnPhase
extends TurnPhase

func phase_start():
	print_debug("battle start")
	turn_start.emit()
	# Spawn enemy wave
	GameManager.spawn_enemy_wave()
	
	# Replace placeholders
	GameManager.spawn_allies()
	pass
	
func phase_end():
	print_debug("battle end")
	turn_end.emit()
	
	# Remove all soldiers from the game
	# Respawn all placeholders
	GameManager.replace_allies()
	TurnManager.next_turn()
	pass
	
func phase_act():
	# Check if all enemies is defeated. 
	# If they are - phase_end.
	pass
