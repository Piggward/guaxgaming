class_name Effect
extends Resource

enum TriggerWindow {ON_HIT, ON_DEAL_DAMAGE, ON_GET_PROJECTILE}
@export var name: String
@export var trigger_window: TriggerWindow

func trigger(attack: Attack, target: Npc) -> void:
	# This is the method to override in specific effect classes.
	pass

func is_enemy(performer: Npc, target: Npc):
	return (target is Enemy and performer is Ally) or (target is Ally and performer is Enemy)
