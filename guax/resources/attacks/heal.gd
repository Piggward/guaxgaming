@tool
class_name Heal
extends Attack

func apply_attack(target: Npc):
	target.take_damage(-damage)
	pass
