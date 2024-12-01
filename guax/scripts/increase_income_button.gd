extends Button
@export var income_increase: int
@export var cost: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TurnManager.shop_turn.turn_start.connect(func(): self.visible = true)
	TurnManager.shop_turn.turn_end.connect(func(): self.visible = false)
	self.pressed.connect(func(): 
		if(GameManager.player_gold >= cost):
			GameManager.transaction(cost)
			GameManager.increase_income(income_increase)
			)
			
			
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
