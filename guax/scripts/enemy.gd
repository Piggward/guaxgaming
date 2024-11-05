class_name Enemy
extends Npc

@export var bounty: int
@onready var enemy_aggrozone = $Aggrozone

func _ready():
	aggrozone = enemy_aggrozone
	super()
