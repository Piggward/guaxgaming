class_name AoeEffect
extends Effect

const AREA_OF_EFFECT = preload("res://scenes/area_of_effect.tscn")
@export var aoe_radius: float
var aoe: AreaOfEffect

func trigger(attack: Attack, target: Npc, projectile: Projectile = null) -> void:
	# Extend AoeEffect script and overwrite this method to customize the aoe-effect.
	for body in aoe.get_overlapping_bodies():
		if body is Npc and is_enemy(attack.performer, body):
			body.take_damage(attack.damage)
			
	aoe.queue_free()
	pass
	
func init(attack: Attack, target: Npc, projectile: Projectile = null):
	instantiate_aoe()
	# For a projectile attack we add the aoe to the projectile. 
	# For melee attacks - to the target directly 
	if attack is ProjectileAttack:
		aoe.global_position = projectile.global_position
		projectile.add_child(aoe)
	else:
		aoe.global_position = target.global_position
		target.get_tree().root.add_child(aoe)
	
func instantiate_aoe():
	var aoe_instance = AREA_OF_EFFECT.instantiate()
	aoe_instance.radius = aoe_radius
	aoe = aoe_instance
