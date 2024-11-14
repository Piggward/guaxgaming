class_name SoldatIdleState
extends NpcState



func  act():
	var enemies: Array[Npc] = find_targets()
	if enemies.is_empty():
		return
	
	transition_requested.emit(self, NpcState.State.HUNTING)

func enter():
	#npc.set_agent_target(npc.global_position)
	npc.play_animation(npc.title+"/Idle")
	# Maybe there is a better way, but if velocity is not reset to zero, then the character will keep moving while in idle.
	npc.velocity = Vector2.ZERO

func exit():
	pass

func find_targets()-> Array[Npc]:
	var found_enemies: Array[Npc]
	var found_bodies = npc.aggrozone.get_overlapping_bodies()
	for body in found_bodies:
		if body is Enemy:
			found_enemies.append(body)
	return found_enemies
