extends Label
@export var income_text: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.player_income_updated.connect(func(f): self.text = income_text + str(f))
	self.text = income_text + str(GameManager.player_income)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
