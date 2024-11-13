class_name AoeEffect
extends Effect

const AREA_OF_EFFECT = preload("res://scenes/area_of_effect.tscn")
@export var aoe_radius: float
var attack: Attack

func trigger(attack: Attack, target: Npc) -> void:
	# This is the method to override in specific effect classes.
	self.attack = attack
	var aoe = create_aoe()
	aoe.global_position = target.global_position
	target.get_tree().root.add_child(aoe)
	pass
	
func create_aoe():
	var aoe = AREA_OF_EFFECT.instantiate()
	aoe.radius = aoe_radius
	aoe.on_contact.connect(aoe_effect)
	return aoe

func aoe_effect(target: Npc):
	# deal damage as standard, but anything could be here
	if is_enemy(attack.performer, target):
		target.take_damage(attack.damage)
