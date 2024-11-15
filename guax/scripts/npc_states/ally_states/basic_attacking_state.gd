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
		var attack = npc.attack
		# Init the attack before it hits to apply aoe effects etc
		attack.init(npc.target)
		npc.play_animation(npc.attack.animation)
		print_debug("Attackerade!")
		await get_tree().create_timer(npc.attackspeed/10).timeout
		attackReady =  true
		
func on_hit():
	npc.attack.on_hit(npc.target)
		
func shoot_projectile():
	var projectile = npc.attack.get_projectile(npc.target)
	projectile.global_position = npc.global_position
	get_tree().root.add_child(projectile)
