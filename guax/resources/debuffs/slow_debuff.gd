class_name Slow
extends Debuff
var speed_reduction
@export var slow_factor:float
func apply(target: Npc):
	var npc_speed = target.speed
	var speed_reduction = npc_speed*slow_factor
	target.speed-= speed_reduction
	pass

func remove(target: Npc):
	target += speed_reduction
	pass
	
func reapply():
	alive_time = 0
	pass
	
func process(delta: float):
	alive_time += delta
	pass
