class_name SplashEffect
extends AoeEffect

@export var splash_dmg_ratio: float
var ignore_target: Npc

func trigger(attack: Attack, target: Npc, projectile: Projectile = null) -> void:
	ignore_target = target
	# Extend AoeEffect script and overwrite this method to customize the aoe-effect.
	for body in aoe.get_overlapping_bodies():
		if body is Npc and attack.performer.is_enemy(body) and body != ignore_target:
			body.take_damage(attack.damage * splash_dmg_ratio)
			
	aoe.queue_free()
