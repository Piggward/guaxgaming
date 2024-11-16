class_name Npc
extends CharacterBody2D
#buuu
#NPC stats
@export var maxHealth = 30
var currentHealth
@export var speed = 30
@export var attackspeed = 30
@export var attack: Attack
@export var title: String

#navigation
@onready var advanced_navigation: AdvancedNavigation = $NavigationAgent2D

var aggrozone: Area2D

#Statemachine
@onready var state_machine = $StateMachine

#animator
@onready var animation_player = $AnimationPlayer

#sprites and collisions
@onready var root_sprites = $Root
@onready var collision_shape = $CollisionShape2D

#placeholder
var placeholder: PlaceholderUnit

signal on_death(npc: Npc)
signal health_updated(new_value: int)
signal receive_damage(amount: int)

#UI Signals:

signal on_input(event: InputEvent)
signal on_mouse_enter()
signal on_mouse_exit()

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	advanced_navigation.set_agent_target(position)
	state_machine.init(self)
	attack.performer = self

func _physics_process(delta: float) -> void:
	state_machine.act()
	move_and_slide()
	
func take_damage(damageTaken:int):
	if is_dead():
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

func set_placeholder(ph: PlaceholderUnit):
	ph.actual_unit = self
	placeholder = ph

func set_health(new_health: int):
	currentHealth = new_health
	health_updated.emit(currentHealth)
	
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
	
func is_enemy(npc: Npc):
	return (npc is Enemy and self is Ally) or (npc is Ally and self is Enemy)
	
func _on_ui_control_gui_input(event):
	input_event.emit(event)
	pass # Replace with function body.

func _on_ui_control_mouse_entered():
	mouse_entered.emit()
	pass # Replace with function body.

func _on_ui_control_mouse_exited():
	mouse_exited.emit()
	pass # Replace with function body.
