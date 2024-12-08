class_name TargetAllyAttack
extends Attack

@export var cd_time: float
@export var initial_cd: bool

func ready():
	super()
	performer.aggrozone.body_entered.connect(_on_aggrozone_update)
	performer.aggrozone.body_exited.connect(_on_aggrozone_update)
		
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
	if initial_cd:
		set_cooldown()
	else:
		super()
