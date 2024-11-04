class_name Npc
extends CharacterBody2D

#NPC stats
@export var maxHealth = 30
var currentHealth
@export var speed = 30
@export var attackDamage = 30
@export var attackRange = 30
@export var isEnemy = false
@export var attackspeed = 30

#Navagent logic
@onready var nav_agent = $NavigationAgent2D
var targetReached = false

var target:Npc
#Aggrozone
var aggrozone:Area2D
#Statemachine
@onready var state_machine: Npc_State_Machine = $StateMachine

#animator
@onready var soldat_animation: Node = $SoldatAnimation





# Called when the node enters the scene tree for the first time.
func _ready():
	aggrozone = get_tree().get_nodes_in_group("Aggrozone")[0]
	
	make_path(position)
	currentHealth = maxHealth
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.act()
	move_and_slide()
	
func make_path(target: Vector2):
	nav_agent.target_position = target
	
func take_damage(damageTaken:int):
	pass
	
#Animations
func play_idle_animation():
	soldat_animation.play_idle()

func play_attack_animation():
	soldat_animation.play_attack()
