class_name AreaOfEffect
extends Area2D

@export var radius: float
@onready var aoe_collision: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aoe_collision.shape.radius = radius
	pass # Replace with function body.
