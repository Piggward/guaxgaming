class_name Stun
extends Debuff

func apply(target: Npc):
	# Example is stun-debuff
	self.target = target
	target.set_physics_process(false)
	target.animation_player.process_mode = Node.PROCESS_MODE_DISABLED

func remove(target: Npc):
	target.set_physics_process(true)
	target.animation_player.process_mode = Node.PROCESS_MODE_INHERIT
	debuff_finish.emit()
	
func reapply():
	alive_time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	alive_time += delta
	if alive_time > duration: 
		remove(target)
