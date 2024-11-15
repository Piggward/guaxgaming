class_name EnemyIdleState
extends NpcState

func act():
	var enemies: Array[Npc] = find_targets()
	if enemies.is_empty():
		npc.calculate_velocity_towards_target(Vector2(26,npc.global_position.y))
		return
	
	transition_requested.emit(self, NpcState.State.HUNTING)

func enter():
	npc.play_animation(npc.title+"/Idle")

func exit():
	pass

func find_targets()-> Array[Npc]:
	var found_enemies: Array[Npc]
	var found_bodies = npc.aggrozone.get_overlapping_bodies()
	for body in found_bodies:
		if (body is Ally and self.npc is Enemy) or (body is Enemy and self.npc is Ally):
			found_enemies.append(body)
	return found_enemies
	
