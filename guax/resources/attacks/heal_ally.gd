class_name HealAlly
extends TargetAllyAttack

func on_hit(target: Npc):
	var on_hit_effects = effects.filter(func(f): return f.trigger_window == Effect.TriggerWindow.ON_HIT)
	for effect: Effect in on_hit_effects:
		effect.trigger(self, target)
	target.take_damage(-damage)
	attack_cooldown.emit()
