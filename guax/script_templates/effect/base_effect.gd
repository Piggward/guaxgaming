extends Effect

# From parent class:
#enum TriggerWindow {ON_HIT, ON_DEAL_DAMAGE, ON_GET_PROJECTILE}
#@export var name: String
#@export var trigger_window: TriggerWindow

func trigger(attack: Attack, target: Npc, projectile: Projectile = null) -> void:
	# This is the method to override in specific effect classes.
	pass

func init(attack: Attack, target: Npc, projectile: Projectile = null):
	pass
