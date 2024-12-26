class_name SoldatAttackingState
extends NpcState

var attack_changed = false
var attacking = false

func act():
	if (attacking):
		return
	if (target==null || target.is_dead() || attack_changed):
		transition_requested.emit(self, NpcState.State.HUNTING)
		return
		
	var distance = (target.global_position-npc.global_position).length()
	if(distance < attack.range):
		try_attack()
	else:
		transition_requested.emit(self, NpcState.State.HUNTING)
		return
	
	npc.rotate_towards_target(target.global_position)
	npc.stand_still()

func enter():
	if attack != npc.attack_manager.current_attack:
		transition_requested.emit(self, NpcState.State.HUNTING)
		
	target.on_death.connect(func(): target = null)
	npc.attack_manager.attack_changed.connect(set_attack_changed)
	if (target!=null):
		npc.velocity = Vector2.ZERO
		return
	else:
		transition_requested.emit(self, NpcState.State.HUNTING)

func set_attack_changed(a):
	attack_changed = true

func exit():
	npc.attack_manager.attack_changed.disconnect(set_attack_changed)
	attack_changed = false
	attacking = false
	pass

func try_attack():
	if(attack.is_ready):
		attacking = true
		attack.init(target)
		npc.play_animation(npc.title+"/Attack1")
		print_debug("Attackerade!")
		npc.animation_player.animation_finished.connect(on_attack_animation_finished)
		
func on_hit():
	attack.on_hit(target)
	
func on_attack_animation_finished(animation):
	attacking = false
		
func shoot_projectile():
	if attack.projectile == null:
		attack.set_cooldown()
		on_hit()
		return
	var projectile = attack.get_projectile(target)
	projectile.global_position = npc.global_position
	get_tree().root.add_child(projectile)
