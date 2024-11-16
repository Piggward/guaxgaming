class_name SoldatHuntingState
extends NpcState

func act():
	var enemies: Array[Npc] = find_targets()
	if enemies.is_empty() or enemies == null:
		if npc is Enemy:
			npc.calculate_velocity_towards_target(Vector2(26,npc.global_position.y))
		else:
			npc.velocity = Vector2.ZERO
		return
	target = target_closest_enemy(enemies)
	if(is_target_in_range()):
		transition_requested.emit(self, NpcState.State.ATTACKING)
		return
	npc.calculate_velocity_towards_target(target.global_position)

func enter():
	pass

func exit():
	pass

func find_targets()-> Array[Npc]:
	var found_enemies: Array[Npc]
	var found_bodies = npc.aggrozone.get_overlapping_bodies()
	for body in found_bodies:
		if body is Npc and npc.is_enemy(body) and !body.is_dead():
			found_enemies.append(body)
	return found_enemies

func target_closest_enemy(enemiesArray:Array[Npc]):
	var lowest_distance = INF
	var target
	for enemy in enemiesArray:
		var distance = (enemy.global_position-npc.global_position).length()
		if(distance<lowest_distance):
			lowest_distance=distance
			target = enemy
	return target
	
func is_target_in_range()->bool:
	var distance = (target.global_position-npc.global_position).length()
	if(distance < npc.attack.range):
		return true
	else:
		return false
