class_name Attack
extends Resource

enum Type {MELEE, RANGED, PHYSICAL, MAGICAL}
enum Target { ENEMY, SELF, ALLY }

@export var damage: int
@export var range: int
@export var types: Array[Type]
@export var target_type: Target
var is_ready = true

# These exported values needs to be duplicated otherwise they cannot be modified.
# Currently starting_effects is duplicated to effects in npc script. 
@export var effects: Array[Effect]

# Who is performing the attack.
var performer: Npc

var cd = false
signal attack_ready()
signal attack_cooldown()

func on_hit(target: Npc):
	# Fetch all effects that has the On_hit TriggerWQindeo
	var on_hit_effects = effects.filter(func(f): return f.trigger_window == Effect.TriggerWindow.ON_HIT)
	for effect: Effect in on_hit_effects:
		effect.trigger(self, target)
	target.take_damage(damage)
	attack_cooldown.emit()
	pass 
	
func init(target: Npc): 
	# This method is called from AttackState when attack starts.
	# It adds the aoes to our attack so its collision is ready when the attack hits. 
	for effect in effects:
		effect.init(self, target)
	set_cooldown()
		
func ready():
	set_effects()
	
func reset():
	cd = false
	is_ready = true
		
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
