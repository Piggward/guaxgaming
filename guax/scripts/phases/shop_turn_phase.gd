class_name ShopTurnPhase
extends TurnPhase

func phase_start():
	turn_start.emit()
	print("shop turn phase start")
	pass
	
func phase_end():
	turn_end.emit()
	print("shop turn phase end")
	TurnManager.next_turn()
	pass
	
func phase_act():
	# Nothing happens here, the player is free to purchase and rearrange allies
	pass
