class_name BounceEffect
extends Effect

@export var bounces: int

func apply(attack: Attack):
	attack.on_projectile_hit.connect(add_effect)
	
func add_effect(attack: Attack, target: Npc, projectile: Projectile):
	target.get_tree().root.add_child(attack.get_projectile())
