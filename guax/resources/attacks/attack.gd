@tool
class_name Attack
extends Resource

enum Type {MELEE, RANGED, PHYSICAL, MAGICAL}
enum Target { ENEMY, SELF, ALLY }

@export var damage: int
@export var range: int
@export var types: Array[Type]
@export var target_type: Target
# These exported values needs to be duplicated otherwise they cannot be modified.
# Currently starting_effects is duplicated to effects in npc script. 
@export var effects: Array[Effect]
@export var cd_on_battle_start: bool
@export var cd_time: float
@export var ranged_attack: bool:
	set(value):
		ranged_attack = value
		notify_property_list_changed()
		
# Will only be set if ranged_attack is true
var projectile: PackedScene
var shoot_speed: float

var is_ready = true
var is_base_attack = false

# Who is performing the attack.
var performer: Npc

var cd = false
signal attack_ready()
signal attack_cooldown()

func _get_property_list() -> Array[Dictionary]:
	var ret: Array[Dictionary] = []
	if (ranged_attack):		
		ret.append({
			"name": "projectile",
			"type": typeof(Resource),
			"hint": PROPERTY_HINT_RESOURCE_TYPE,    # We tell we want to edit a Resource
			"hint_string": "PackedScene",               # And explicitly a Texture
		})
		ret.append({
			"name": "shoot_speed",
			"type": TYPE_FLOAT,
		})

	return ret
	
func apply_attack(target:Npc):
	target.take_damage(damage)

func on_hit(target: Npc):
	# Fetch all effects that has the On_hit TriggerWQindeo
	var on_hit_effects = effects.filter(func(f): return f.trigger_window == Effect.TriggerWindow.ON_HIT)
	for effect: Effect in on_hit_effects:
		effect.trigger(self, target)
	apply_attack(target)
	attack_cooldown.emit()
	pass 
	
func init(target: Npc): 
	if ranged_attack:
		return
	# This method is called from AttackState when attack starts.
	# It adds the aoes to our attack so its collision is ready when the attack hits. 
	for effect in effects:
		effect.init(self, target)
	set_cooldown()
		
func ready():
	set_effects()
	if target_type == Target.ALLY:
		performer.aggrozone.body_entered.connect(_on_aggrozone_update)
		performer.aggrozone.body_exited.connect(_on_aggrozone_update)
	
func reset():
	if cd_on_battle_start:
		set_cooldown()
		return
	cd = false
	is_ready = check_conditions()
		
func set_effects():
	var effects_copy: Array[Effect]
	for effect in effects:
		effects_copy.append(effect.duplicate())
	effects = effects_copy
	
func set_cooldown():
	cd = true
	is_ready = false
	await performer.get_tree().create_timer(cooldown_time()).timeout
	cd = false
	if check_conditions():
		set_attack_ready()
	
func cooldown_time():
	return performer.attackspeed / 10 if is_base_attack else cd_time
	
func check_conditions():
	if target_type == Target.ALLY:
		# An ally must exist to perform this attack
		return cd == false && performer.aggrozone.get_overlapping_bodies().any(func(b): return b is Npc and not performer.is_enemy(b) and not b.is_dead() and not b == performer)
	return cd == false

func set_attack_ready(): 
	is_ready = true
	attack_ready.emit()
	
func set_to_base_attack():
	self.is_base_attack = true
	self.cd_on_battle_start = false
		
func _on_aggrozone_update(body):
	if not body is Npc:
		return
	if performer.is_enemy(body):
		return
	check_conditions()
	
func get_projectile(target: Npc):
	var p = projectile.instantiate()
	p.target_reached.connect(on_hit)
	p.target = target
	p.travel_speed = shoot_speed
	init_ranged(target, p)
	var on_get_projectile_effects = effects.filter(func(f): return f.trigger_window == Effect.TriggerWindow.ON_GET_PROJECTILE)
	for effect: Effect in on_get_projectile_effects:
		effect.trigger(self, target, p)
	return p
	
func init_ranged(target, projectile):
	# This method will add the aoe to our projectile so its collision is ready when it hits. 
	for effect in effects:
		effect.init(self, target, projectile)
	set_cooldown()
