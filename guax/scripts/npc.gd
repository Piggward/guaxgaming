class_name Npc
extends CharacterBody2D

#NPC stats
@export var maxHealth = 30
var currentHealth
@export var speed = 30
@export var attackspeed = 30
@export var attack: Attack
@export var title: String

#Navagent logic
@onready var nav_agent = $NavigationAgent2D
var targetReached = false

var target:Npc
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

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	make_path(position)
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.act()
	move_and_slide()
	
func make_path(target: Vector2):
	nav_agent.target_position = target
	
func take_damage(damageTaken:int):
	receive_damage.emit(damageTaken)
	set_health(currentHealth - damageTaken)
	if currentHealth <= 0:
		die()
		# implement more stuff for dying event here
	pass
	
func die():
	on_death.emit(self)
	self.queue_free()
	
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
