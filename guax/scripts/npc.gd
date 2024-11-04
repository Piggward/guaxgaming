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
@onready var root = $Root

# Soldier specific code
const PLACEHOLDER_UNIT = preload("res://scenes/placeholder_unit.tscn")
const SOLDAT_SPRITES = preload("res://scenes/character_sprites/soldat_sprites.tscn")
var battle_start_location: Vector2
@export var cost: int
@export var title: String
@export var flavor_text: String
var placeholder: PlaceholderUnit

signal on_death(npc: Npc)

# Called when the node enters the scene tree for the first time.
func _ready():
	aggrozone = get_tree().get_nodes_in_group("Aggrozone")[0]
	
	make_path(position)
	currentHealth = maxHealth
	state_machine.init(self)
	set_placeholder()

func _physics_process(delta: float) -> void:
	state_machine.act()
	move_and_slide()
	
func make_path(target: Vector2):
	nav_agent.target_position = target
	
func take_damage(damageTaken:int):
	currentHealth -= damageTaken
	if currentHealth <= 0:
		on_death.emit(self)
		self.queue_free()
		# implement more stuff for dying event here
	pass
	
#Animations
func play_idle_animation():
	soldat_animation.play_idle()

func play_attack_animation():
	soldat_animation.play_attack()
	
func set_placeholder():
	var placeholderunit = PLACEHOLDER_UNIT.instantiate()
	var sprites = SOLDAT_SPRITES.instantiate()
	for child in sprites.get_children():
		if child is CollisionShape2D:
			child.reparent(placeholderunit)
	placeholderunit.add_child(sprites)
	placeholderunit.actual_soldier = self
	placeholderunit.placed.connect(update_start_location)
	placeholder = placeholderunit
	pass
	
func get_placeholder():
	if placeholder == null:
		set_placeholder()
	return placeholder

func update_start_location(placeholder: PlaceholderUnit):
	self.battle_start_location = placeholder.battle_position
