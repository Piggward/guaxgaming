class_name Debuff
extends Resource

@export var duration: float
@export var debuff_name: String
var target: Npc
var alive_time: float

signal debuff_finish

func apply(target: Npc):
	pass

func remove(target: Npc):
	pass
	
func reapply():
	pass
	
func process(delta: float):
	alive_time += delta
	pass
