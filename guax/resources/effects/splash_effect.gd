class_name SplashEffect
extends AoeEffect

@export var splash_dmg_ratio: float
var ignore_target: Npc

func trigger(attack: Attack, target: Npc) -> void:
	ignore_target = target
	super(attack, target)

func aoe_effect(target: Npc):
	# deal damage as standard, but anything could be here
	if is_enemy(attack.performer, target) and target != ignore_target:
		target.take_damage(attack.damage)
