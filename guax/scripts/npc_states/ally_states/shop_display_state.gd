class_name ShopDisplayState
extends OutOfBattleState

func enter():
	pass

func exit():
	pass
	
func pick_from_shop():
	transition_requested.emit(self, OutOfBattleState.State.DRAGGING)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
