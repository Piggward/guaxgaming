class_name TestSoldier
extends CharacterBody2D

@export var attributes: TestSoldierResource
@export var sprite2D: Array[Sprite2D]
@export var collisionShapes: Array[CollisionShape2D]
var placeholder: PlaceholderUnit
var battle_start_location: Vector2
const PLACEHOLDER_UNIT = preload("res://scenes/placeholder_unit.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	placeholder = get_placeholder()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_placeholder():
	var placeholder = PLACEHOLDER_UNIT.instantiate()
	for s in sprite2D:
		placeholder.add_child(s)
	for c in collisionShapes:
		placeholder.add_child(c)
	placeholder.actual_soldier = self
	placeholder.placed.connect(update_start_location)
	return placeholder
	pass
	
func update_start_location(placeholder: PlaceholderUnit):
	self.battle_start_location = placeholder.battle_position
