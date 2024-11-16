class_name SoldatAttackingState
extends NpcState

var attackReady = true

func  act():
	if (target==null || target.is_dead()):
		transition_requested.emit(self, NpcState.State.HUNTING)
		return
		
	var distance = (target.global_position-npc.global_position).length()
	if(distance < npc.attack.range):
		attack()
	else:
		transition_requested.emit(self, NpcState.State.HUNTING)
		return
	
	npc.rotate_towards_target(target.global_position)
	npc.stand_still()

func enter():
	target.on_death.connect(func(): target = null)
	if (target!=null):
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
		attack.init(target)
		npc.play_animation(npc.title+"/Attack1")
		print_debug("Attackerade!")
		await get_tree().create_timer(npc.attackspeed/10).timeout
		attackReady =  true
		
func on_hit():
	npc.attack.on_hit(target)
		
func shoot_projectile():
	var projectile = npc.attack.get_projectile(target)
	projectile.global_position = npc.global_position
	get_tree().root.add_child(projectile)
