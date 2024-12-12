class_name AttackManager
extends Node

@onready var npc = $".."

var current_attack: Attack

signal attack_changed(attack: Attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	if !npc.is_node_ready():
		await npc.ready
	
	current_attack = get_next_attack()
	TurnManager.battle_turn.turn_start.connect(_on_battle_start)
	TurnManager.battle_turn.turn_end.connect(_on_battle_end)
	pass # Replace with function body.

func _on_battle_start():
	for attack in npc.special_attacks:
		attack.reset()
	npc.base_attack.reset()
	update_next_attack()
	
func _on_battle_end():
	pass

func get_next_attack() -> Attack:
	# Get all ready attacks
	var ready_attacks = npc.special_attacks.filter(func(a: Attack): return a.is_ready)
	if ready_attacks.size() > 0:
		return ready_attacks[ready_attacks.size() - 1]
	else:
		return npc.base_attack
		
func update_next_attack(): 
	var a = get_next_attack()
	if a != current_attack:
		attack_changed.emit(a)
		current_attack = a
	
