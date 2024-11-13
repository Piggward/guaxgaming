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
	var on_hit_effects = effects.filter(func(f): return f.trigger_window == Effect.TriggerWindow.ON_HIT)
	for effect: Effect in on_hit_effects:
		effect.trigger(self, target)
	pass 
