class_name ApplyDebuff
extends Effect

# From parent class:
#enum TriggerWindow {ON_HIT, ON_DEAL_DAMAGE, ON_GET_PROJECTILE}
#@export var name: String
#@export var trigger_window: TriggerWindow
@export var debuff: Debuff

func trigger(attack: Attack, target: Npc, projectile: Projectile = null) -> void:
	var debuff_node = DebuffNode.new()
	debuff_node.debuff = debuff.duplicate()
	target.apply_debuff(debuff_node)
	pass

func init(attack: Attack, target: Npc, projectile: Projectile = null):
	pass
