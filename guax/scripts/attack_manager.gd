class_name AttackManager
extends Node

@export var special_attacks: Array[Attack]
@onready var npc = $".."
@export var base_attack: Attack

signal attack_changed(attack: Attack)
var current_attack: Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	if !npc.is_node_ready():
		await npc.ready
	
	duplicate_attacks()
	current_attack = get_next_attack()
	TurnManager.battle_turn.turn_start.connect(_on_battle_start)
	TurnManager.battle_turn.turn_end.connect(_on_battle_end)
	pass # Replace with function body.

func _on_battle_start():
	for attack in special_attacks:
		attack.reset()
	base_attack.reset()
	update_next_attack()
	
func _on_battle_end():
	pass

func get_next_attack() -> Attack:
	# Get all ready attacks
	var ready_attacks = special_attacks.filter(func(a: Attack): return a.is_ready)
	if ready_attacks.size() > 0:
		return ready_attacks[ready_attacks.size() - 1]
	else:
		return base_attack
		
func update_next_attack(): 
	var a = get_next_attack()
	if a != current_attack:
		attack_changed.emit(a)
		current_attack = a
		
func duplicate_attacks():
	# Important to duplicate the starting attack here, upgrades applied to the attack will 
	# effect all starting attacks otherwise. 
	var special_attacks_copy: Array[Attack]
	for at: Attack in special_attacks:
		# Set effects also duplicates the effects in the attack.
		var a = at.duplicate()
		a.performer = npc
		a.ready()
		a.attack_cooldown.connect(update_next_attack)
		a.attack_ready.connect(update_next_attack)
		special_attacks_copy.append(a)
	special_attacks = special_attacks_copy
	
	# duplicate base_attack:
	var base_attack_copy = base_attack.duplicate()
	base_attack_copy.performer = npc
	base_attack_copy.is_base_attack = true;
	base_attack_copy.ready()
	base_attack_copy.set_to_base_attack()
	base_attack = base_attack_copy
	
