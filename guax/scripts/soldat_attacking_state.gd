class_name SoldatAttackingState
extends NpcState


var attackReady = true
func  act():
	if (npc.target==null):
		transition_requested.emit(self, NpcState.State.HUNTING)
		return
		
	var distance = (npc.target.global_position-npc.global_position).length()
	if(distance < npc.attackRange):
		attack()
	else:
		transition_requested.emit(self, NpcState.State.HUNTING)
		return
	
	rotate_towards_target(npc.target)
	

func enter():
	if (npc.target!=null):
		npc.velocity = Vector2.ZERO
		return
	else:
		transition_requested.emit(self, NpcState.State.HUNTING)

func exit():
	pass

func attack():
	if(attackReady):
		attackReady=false
		npc.target.take_damage(npc.attackDamage)
		npc.play_attack_animation()
		print_debug("Attackerade!")
		await get_tree().create_timer(npc.attackspeed/10).timeout
		attackReady =  true
		
func rotate_towards_target(target:Npc):
	npc.look_at(target.global_position)	
