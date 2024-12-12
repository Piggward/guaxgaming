class_name Npc
extends CharacterBody2D


@export var base_attributes: BaseAttributes

#NPC stats
var maxHealth = 30
var currentHealth
var speed = 30
var attackspeed = 30
var title: String

#NPC attacks
var special_attacks: Array[Attack]
var base_attack: Attack

#navigation
@onready var advanced_navigation: AdvancedNavigation = $NavigationAgent2D

var aggrozone: Area2D

#Statemachine
@onready var state_machine = $StateMachine

@onready var attack_manager = $AttackManager

#animator
@onready var animation_player = $AnimationPlayer

#sprites and collisions
@onready var root_sprites = $Root
@onready var collision_shape = $CollisionShape2D

signal on_death(npc: Npc)
signal health_updated(new_value: int)
signal receive_damage(amount: int)

#UI Signals:
signal on_input(event: InputEvent)
signal mouse_enter()
signal mouse_exit()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_attributes()
	duplicate_attacks()
	advanced_navigation.set_agent_target(position)
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.act()
	move_and_slide()
	
func take_damage(damageTaken:int):
	if !can_take_damage():
		return
	receive_damage.emit(damageTaken)
	set_health(currentHealth - damageTaken)
	if currentHealth <= 0:
		die()
		# implement more stuff for dying event here
	pass
	
func die():
	on_death.emit(self)
	deactivate()
	
#Animations
func play_animation(animation: String):
	animation_player.play_animation(animation)

func set_health(new_health: int):
	currentHealth = new_health
	health_updated.emit(currentHealth)
	
func set_attributes():
	speed = base_attributes.speed
	attackspeed = base_attributes.attackspeed
	maxHealth = base_attributes.maxHealth
	title = base_attributes.title
	currentHealth = maxHealth
	
func duplicate_attacks():
	# Important to duplicate the attacks here, upgrades applied to the attack will 
	# effect all attacks otherwise. 
	for at: Attack in base_attributes.special_attacks:
		# Set effects also duplicates the effects in the attack.
		var a = at.duplicate()
		a.performer = self
		a.ready()
		a.attack_cooldown.connect(attack_manager.update_next_attack)
		a.attack_ready.connect(attack_manager.update_next_attack)
		special_attacks.append(a)
	
	# duplicate base_attack:
	base_attack = base_attributes.base_attack.duplicate()
	base_attack.performer = self
	base_attack.is_base_attack = true;
	base_attack.ready()
	base_attack.set_to_base_attack()
	
func deactivate():
	self.visible = false
	process_mode = PROCESS_MODE_DISABLED
	animation_player.stop()
	pass

func activate():
	self.visible = true
	process_mode = PROCESS_MODE_INHERIT
	pass

#States call this to move character in direction
func calculate_velocity_towards_target(target_position:Vector2):
	advanced_navigation.calculate_velocity(target_position)
	rotate_towards_target(target_position)
func stand_still():
	advanced_navigation.stand_still()

func rotate_towards_target(target_position:Vector2):
	look_at(target_position)
	
func is_dead():
	return state_machine.current_state.state == NpcState.State.DEAD
	
func can_take_damage():
	return !is_dead() and TurnManager.current_phase.phase == TurnPhase.Phase.BATTLE 
	
func is_enemy(npc: Npc):
	return (npc is Enemy and self is Ally) or (npc is Ally and self is Enemy)
	
func _on_ui_control_gui_input(event):
	on_input.emit(event)
	pass # Replace with function body.

func _on_ui_control_mouse_entered():
	mouse_entered.emit()
	pass # Replace with function body.

func _on_ui_control_mouse_exited():
	mouse_exit.emit()
	pass # Replace with function body.
