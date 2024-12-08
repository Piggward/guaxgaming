class_name BasicHuntingState
extends NpcState

func act():
	var targets = find_targets()
	match attack.target_type:
		Attack.Target.SELF:
			target = npc
			transition_requested.emit(self, NpcState.State.ATTACKING)
		Attack.Target.ENEMY:
			target = find_closest_target(targets.filter(func(t): return npc.is_enemy(t)))
		Attack.Target.ALLY:
			target = find_closest_target(targets.filter(func(t): return !npc.is_enemy(t)))
	
	if target == null:
		return		
	if(is_target_in_range()):
		transition_requested.emit(self, NpcState.State.ATTACKING)
		return
	npc.calculate_velocity_towards_target(target.global_position)

func find_closest_target(targets: Array[Npc]) -> Npc:
	if targets.is_empty() or targets == null:
		if npc is Enemy:
			npc.calculate_velocity_towards_target(Vector2(26,npc.global_position.y))
		else:
			npc.velocity = Vector2.ZERO
		return null
	return closest_target(targets)

func enter():
	attack = npc.attack_manager.current_attack
	npc.attack_manager.attack_changed.connect(func(a): attack = a)
	pass

func exit():
	pass

func find_targets()-> Array[Npc]:
	var found_targets: Array[Npc]
	var found_bodies = npc.aggrozone.get_overlapping_bodies()
	for body in found_bodies:
		if body is Npc and !body.is_dead() and body != npc:
			found_targets.append(body)
	return found_targets

func closest_target(targets: Array[Npc]):
	var lowest_distance = INF
	var target
	for t in targets:
		var distance = (t.global_position-npc.global_position).length()
		if(distance<lowest_distance):
			lowest_distance=distance
			target = t
	return target
	
func is_target_in_range()->bool:
	var distance = (target.global_position-npc.global_position).length()
	if(distance < attack.range):
		return true
	else:
		return false
