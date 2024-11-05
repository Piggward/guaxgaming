class_name SoldatHuntingState
extends NpcState


func  act():
	var enemies: Array[Npc] = find_targets()
	if enemies.is_empty() or enemies == null:
		transition_requested.emit(self, NpcState.State.IDLE)
		return
	var target = target_closest_enemy(enemies)
	if(is_target_in_range(target)):
		npc.target = target
		transition_requested.emit(self, NpcState.State.ATTACKING)
		return
	set_agent_target(target)
	calculateNewVelocityTarget()
	rotate_towards_target(target)
	

func enter():
	npc.nav_agent.navigation_finished.connect(_on_nav_finished)
	npc.nav_agent.velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)

func exit():
	npc.nav_agent.navigation_finished.disconnect(_on_nav_finished)
	npc.nav_agent.velocity_computed.disconnect(_on_navigation_agent_2d_velocity_computed)

func find_targets()-> Array[Npc]:
	var found_enemies: Array[Npc]
	var found_bodies = npc.aggrozone.get_overlapping_bodies()
	for body in found_bodies:
		if body is Enemy:
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

func set_agent_target(targetEnemy:Npc):
	npc.make_path(targetEnemy.global_position)

func _on_nav_finished():
	pass

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	npc.velocity = npc.velocity.move_toward(safe_velocity,1000)

func calculateNewVelocityTarget():
	var next_path_pos = npc.nav_agent.get_next_path_position()
	var direction = npc.global_position.direction_to(next_path_pos)
	var new_velocity = direction * npc.speed
	npc.nav_agent.velocity = new_velocity

func is_target_in_range(targetEnemy:Npc)->bool:
	var distance = (targetEnemy.global_position-npc.global_position).length()
	if(distance < npc.attack.range):
		return true
	else:
		return false

func rotate_towards_target(target:Npc):
	npc.look_at(target.global_position)
