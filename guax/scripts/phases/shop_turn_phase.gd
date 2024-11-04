class_name ShopTurnPhase
extends TurnPhase

func _ready():
	phase = TurnPhase.Phase.SHOPPING

func phase_start():
	print("shop turn phase start")
	pass
	
func phase_end():
	print("shop turn phase end")
	TurnManager.next_turn()
	pass
	
func phase_act():
	# Nothing happens here, the player is free to purchase and rearrange soldiers
	pass
