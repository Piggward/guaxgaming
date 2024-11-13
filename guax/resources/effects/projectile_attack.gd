class_name ProjectileAttack
extends Attack

@export var projectile: PackedScene
@export var shoot_speed: float

func get_projectile(target: Npc):
	var p = projectile.instantiate()
	p.target_reached.connect(on_hit)
	p.target = target
	p.travel_speed = shoot_speed
	return p
