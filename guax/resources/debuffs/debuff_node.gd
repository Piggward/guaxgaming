class_name DebuffNode
extends Node

@export var debuff: Debuff
var debuff_name: String

func _ready() -> void:
	debuff.debuff_finish.connect(func(): self.queue_free())
	debuff_name = debuff.debuff_name
	pass

func apply_debuff(target: Npc):
	debuff.apply(target)
	pass

func remove_debuff(target: Npc):
	debuff.remove(target)
	pass
	
func reapply_debuff():
	debuff.reapply()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debuff.process(delta)
	pass
