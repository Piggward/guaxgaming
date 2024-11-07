class_name SoldatAttackingState
extends NpcState


var attackReady = true
func  act():
	if (npc.target==null):
		transition_requested.emit(self, NpcState.State.HUNTING)
		return
		
	var distance = (npc.target.global_position-npc.global_position).length()
	if(distance < npc.attack.range):
		attack()
	else:
		transition_requested.emit(self, NpcState.State.HUNTING)
		return
	
	npc.rotate_towards_target(npc.target.global_position)
	npc.stand_still()
	

func enter():
	npc.target.on_death.connect(func(): npc.target = null)
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
		npc.play_animation(npc.attack.animation)
		print_debug("Attackerade!")
		await get_tree().create_timer(npc.attackspeed/10).timeout
		attackReady =  true
		
func deal_damage():
	if npc.target == null:
		return
	npc.target.take_damage(npc.attack.damage)
		
