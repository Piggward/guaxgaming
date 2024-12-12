@tool
class_name HealAlly
extends Attack

func apply_attack(target: Npc):
	target.take_damage(-damage)
	pass
