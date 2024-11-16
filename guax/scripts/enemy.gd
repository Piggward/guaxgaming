class_name Enemy
extends Npc

@export var bounty: int
@onready var enemy_aggrozone = $Aggrozone

func _ready():
	aggrozone = enemy_aggrozone
	TurnManager.battle_turn.turn_end.connect(_on_battle_turn_end)
	super()

func _on_battle_turn_end():
	await get_tree().create_timer(1).timeout
	self.queue_free()
