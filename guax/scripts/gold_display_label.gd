extends Label

var gold_text = "GOLD:  "

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player_gold_updated.connect(func(f): self.text = gold_text + str(f))
	self.text = gold_text + str(GameManager.player_gold)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
