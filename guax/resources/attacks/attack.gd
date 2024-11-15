class_name Attack
extends Resource

enum Type {MELEE, RANGED, PHYSICAL, MAGICAL}

@export var damage: int
@export var range: int
@export var types: Array[Type]
@export var animation: String

@export var effects: Array[Effect]
# Who is performing the attack.
var performer: Npc

func on_hit(target: Npc):
	# Fetch all effects that has the On_hit TriggerWQindeo
	var on_hit_effects = effects.filter(func(f): return f.trigger_window == Effect.TriggerWindow.ON_HIT)
	for effect: Effect in on_hit_effects:
		effect.trigger(self, target)
	target.take_damage(damage)
	pass 
	
func init(target: Npc): 
	# This method is called from AttackState when attack starts.
	# It adds the aoes to our attack so its collision is ready when the attack hits. 
	for effect in effects:
		effect.init(self, target)
