extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.shop_turn.turn_start.connect(func(): self.visible = true)
	TurnManager.shop_turn.turn_end.connect(func(): self.visible = false)
	self.pressed.connect(func(): TurnManager.end_phase_requested.emit())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
