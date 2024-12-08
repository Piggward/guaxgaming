class_name AttackManager
extends Node

@export var attacks: Array[Attack]
@onready var npc = $".."

signal attack_changed(attack: Attack)
var current_attack: Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	if !npc.is_node_ready():
		await npc.ready
	# Important to duplicate the starting attack here, upgrades applied to the attack will 
	# effect all starting attacks otherwise. 
	var attacks_copy: Array[Attack]
	for at: Attack in attacks:
		# Set effects also duplicates the effects in the attack.
		var a = at.duplicate()
		a.performer = npc
		a.ready()
		a.attack_cooldown.connect(update_next_attack)
		a.attack_ready.connect(update_next_attack)
		attacks_copy.append(a)
	attacks = attacks_copy
	npc.base_attack = attacks[0]
	current_attack = get_next_attack()
	TurnManager.battle_turn.turn_start.connect(_on_battle_start)
	TurnManager.battle_turn.turn_end.connect(_on_battle_end)
	pass # Replace with function body.

func _on_battle_start():
	for attack in attacks:
		attack.reset()
	update_next_attack()
	
func _on_battle_end():
	pass

func get_next_attack() -> Attack:
	# Get all ready attacks
	var ready_attacks = attacks.filter(func(a: Attack): return a.is_ready)
	if ready_attacks.size() > 0:
		return ready_attacks[ready_attacks.size() - 1]
	else:
		return attacks[0]
		
func update_next_attack(): 
	var a = get_next_attack()
	if a != current_attack:
		attack_changed.emit(a)
		current_attack = a
