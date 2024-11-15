class_name ProjectileAttack
extends Attack

@export var projectile: PackedScene
@export var shoot_speed: float

func get_projectile(target: Npc):
	var p = projectile.instantiate()
	p.target_reached.connect(on_hit)
	p.target = target
	p.travel_speed = shoot_speed
	init_ranged(target, p)
	var on_get_projectile_effects = effects.filter(func(f): return f.trigger_window == Effect.TriggerWindow.ON_GET_PROJECTILE)
	for effect: Effect in on_get_projectile_effects:
		effect.trigger(self, target, p)
	return p
	
func init(target):
	# overwrite this method to do nothing. 
	# ranged attacks gets initiated during the get_projectile method instead.
	pass
	
func init_ranged(target, projectile):
	# This method will add the aoe to our projectile so its collision is ready when it hits. 
	for effect in effects:
		effect.init(self, target, projectile)
