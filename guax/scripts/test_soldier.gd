class_name TestSoldier
extends CharacterBody2D

@export var attributes: TestSoldierResource
@export var sprite2D: Array[Sprite2D]
@export var collisionShapes: Array[CollisionShape2D]
var battle_start_location: Vector2
const PLACEHOLDER_UNIT = preload("res://scenes/placeholder_unit.tscn")
const SOLDAT_SPRITES = preload("res://scenes/character_sprites/soldat_sprites.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_placeholder():
	var placeholder = PLACEHOLDER_UNIT.instantiate()
	var sprites = SOLDAT_SPRITES.instantiate()
	placeholder.add_child(sprites)
	var count = placeholder.get_child_count()
	placeholder.add_child(Sprite2D.new())
	count = placeholder.get_child_count()
	placeholder.actual_soldier = self
	placeholder.placed.connect(update_start_location)
	return placeholder
	pass
	
func update_start_location(placeholder: PlaceholderUnit):
	self.battle_start_location = placeholder.battle_position
