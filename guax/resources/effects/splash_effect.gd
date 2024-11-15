class_name SplashEffect
extends AoeEffect

@export var splash_dmg_ratio: float
var ignore_target: Npc

func trigger(attack: Attack, target: Npc, projectile: Projectile = null) -> void:
	ignore_target = target
	super(attack, target)
