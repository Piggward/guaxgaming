class_name SoldatIdleState
extends NpcState



func  act():
	var enemies: Array[Npc] = find_targets()
	if enemies.is_empty():
		return
	
	transition_requested.emit(self, NpcState.State.HUNTING)

func enter():
	npc.make_path(npc.global_position)
	npc.play_idle_animation()

func exit():
	pass

func find_targets()-> Array[Npc]:
	var found_enemies: Array[Npc]
	var found_bodies = npc.aggrozone.get_overlapping_bodies()
	for body in found_bodies:
		if body is Npc:
			if body.isEnemy != npc.isEnemy:
				found_enemies.append(body)
	return found_enemies
