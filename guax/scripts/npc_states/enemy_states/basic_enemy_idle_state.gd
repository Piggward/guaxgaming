class_name EnemyIdleState
extends NpcState

func act():
	var enemies: Array[Npc] = find_targets()
	if enemies.is_empty():
		calculateNewVelocityTarget()
		rotate_towards_direction(Vector2(26,npc.global_position.y))
		return
	
	transition_requested.emit(self, NpcState.State.HUNTING)

func enter():
	npc.make_path(Vector2(26,npc.global_position.y))
	npc.play_animation("Idle")
	npc.nav_agent.navigation_finished.connect(_on_nav_finished)
	npc.nav_agent.velocity_computed.connect(_on_navigation_agent_2d_velocity_computed)

func exit():
	npc.nav_agent.navigation_finished.disconnect(_on_nav_finished)
	npc.nav_agent.velocity_computed.disconnect(_on_navigation_agent_2d_velocity_computed)

func find_targets()-> Array[Npc]:
	var found_enemies: Array[Npc]
	var found_bodies = npc.aggrozone.get_overlapping_bodies()
	for body in found_bodies:
		if (body is Ally and self.npc is Enemy) or (body is Enemy and self.npc is Ally):
			found_enemies.append(body)
	return found_enemies
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	npc.velocity = npc.velocity.move_toward(safe_velocity,1000)
	
func _on_nav_finished():
	pass

func calculateNewVelocityTarget():
	var next_path_pos = npc.nav_agent.get_next_path_position()
	var direction = npc.global_position.direction_to(next_path_pos)
	var new_velocity = direction * npc.speed
	npc.nav_agent.velocity = new_velocity

func rotate_towards_direction(dir:Vector2):
	npc.look_at(dir)
