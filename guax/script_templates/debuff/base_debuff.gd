extends Debuff

func apply(target: Npc):
	pass

func remove(target: Npc):
	pass
	
func reapply():
	pass
	
func process(delta: float):
	alive_time += delta
	pass
