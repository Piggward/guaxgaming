class_name Attack
extends Resource

enum Type {MELEE, RANGED, PHYSICAL, MAGICAL}

@export var damage: int
@export var range: int
@export var types: Array[Type]
@export var animation: String
@export var projectile: PackedScene
@export var aoe_radius: float

# Who is performing the attack.
var performer: Npc
var aoe: Area2D

func on_hit(target: Npc):
	#deal damage
	target.take_damage(damage)
	if types.any(func(t): return t == Type.MELEE):
		apply_effect_in_aoe()
		
	pass 
	
func get_projectile(target: Npc):
	var p = projectile.instantiate()
	p.target_reached.connect(on_hit)
	
	# add aoe area to projectile.
	if aoe_radius > 0:
		var aoe = Area2D.new()
		var collision = CollisionShape2D.new()
		collision.shape = CircleShape2D.new()
		collision.shape.set_radius(aoe_radius)
		aoe.add_child(collision)
		p.add_child(aoe)
	p.target = target
	return p
	
func apply_effect_in_aoe():
	for body in aoe.get_overlapping_bodies():
		if body is Npc and is_enemy(body):
			body.take_damage(damage)
		
func is_enemy(npc: Npc):
	return (npc is Enemy and performer is Ally) or (npc is Ally and performer is Enemy)
