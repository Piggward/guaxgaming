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
@export var ranged_attack: bool:
	set(value):
		ranged_attack = value
		notify_property_list_changed()
		
# Will only be set if ranged_attack is true
var projectile: PackedScene
var shoot_speed: float

var is_ready = true

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

func on_hit(target: Npc):
	# Fetch all effects that has the On_hit TriggerWQindeo
	var on_hit_effects = effects.filter(func(f): return f.trigger_window == Effect.TriggerWindow.ON_HIT)
	for effect: Effect in on_hit_effects:
		effect.trigger(self, target)
	target.take_damage(damage)
	attack_cooldown.emit()
	pass 
	
func init(target: Npc): 
	if ranged_attack:
		pass
	# This method is called from AttackState when attack starts.
	# It adds the aoes to our attack so its collision is ready when the attack hits. 
	for effect in effects:
		effect.init(self, target)
	set_cooldown()
		
func ready():
	set_effects()
	
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
	return performer.attackspeed / 10
	
func check_conditions():
	return cd == false

func set_attack_ready(): 
	is_ready = true
	attack_ready.emit()
	
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
