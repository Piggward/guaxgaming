extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.shop_turn.turn_start.connect(_on_shop_turn_start)
	TurnManager.shop_turn.turn_end.connect(_on_shop_turn_end)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_shop_turn_start():
	self.visible = true
	
func _on_shop_turn_end():
	self.visible = false
