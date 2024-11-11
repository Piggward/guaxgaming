class_name Attack
extends Resource

enum Type {MELEE, RANGED, PHYSICAL, MAGICAL}

@export var damage: int
@export var range: int
@export var types: Array[Type]
@export var animation: String
@export var projectile: PackedScene
@export var aoe_radius: float
const AREA_OF_EFFECT = preload("res://scenes/area_of_effect.tscn")

# Who is performing the attack.
var performer: Npc

func on_hit(target: Npc):
	# deal damage as standard, but anything could be here
	target.take_damage(damage)
	
	# If aoe - Add aoe-effect to the scene tree
	if aoe_radius > 0: 
		var aoe = create_aoe()
		aoe.global_position = target.global_position
		target.get_tree().root.add_child(aoe)
	pass 
	
func get_projectile(target: Npc):
	var p = projectile.instantiate()
	p.target_reached.connect(on_hit)
	p.target = target
	return p

func aoe_effect(target: Npc):
	# deal damage as standard, but anything could be here
	if is_enemy(target):
		target.take_damage(damage)

func is_enemy(npc: Npc):
	return (npc is Enemy and performer is Ally) or (npc is Ally and performer is Enemy)

func create_aoe():
	var aoe = AREA_OF_EFFECT.instantiate()
	aoe.radius = aoe_radius
	aoe.on_contact.connect(aoe_effect)
	return aoe
