class_name EnemyHuntingState
extends NpcState

func act():
	var enemies: Array[Npc] = find_targets()
	if enemies.is_empty():
		transition_requested.emit(self, NpcState.State.IDLE)
		return
	var target = target_closest_enemy(enemies)
	if(is_target_in_range(target)):
		npc.target = target
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
		if body is Ally:
			found_enemies.append(body)
	return found_enemies

func target_closest_enemy(enemiesArray:Array[Npc]) -> Npc:
	var lowest_distance = INF
	var target
	for enemy in enemiesArray:
		var distance = (enemy.global_position-npc.global_position).length()
		if(distance<lowest_distance):
			lowest_distance=distance
			target = enemy
		
	return target



func is_target_in_range(targetEnemy:Npc)->bool:
	var distance = (targetEnemy.global_position-npc.global_position).length()
	if(distance < npc.attack.range):
		return true
	else:
		return false
