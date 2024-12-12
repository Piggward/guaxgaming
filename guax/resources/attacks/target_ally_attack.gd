class_name TargetAllyAttack
extends ProjectileAttack

func ready():
	super()
	performer.aggrozone.body_entered.connect(_on_aggrozone_update)
	performer.aggrozone.body_exited.connect(_on_aggrozone_update)
	is_ready = !cd_on_battle_start && check_conditions()
		
func _on_aggrozone_update(body):
	if not body is Npc:
		return
	if performer.is_enemy(body):
		return
	check_conditions()
	
func check_conditions():
	var allies_in_aggrozone = performer.aggrozone.get_overlapping_bodies().any(func(b): return b is Npc and not performer.is_enemy(b) and not b.is_dead() and not b == performer)
	return super() && allies_in_aggrozone
	
func cooldown_time():
	return cd_time
	
func reset():
	if cd_on_battle_start:
		set_cooldown()
	else:
		super()
