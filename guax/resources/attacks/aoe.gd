class_name AreaOfEffect
extends Area2D

@export var radius: float
@onready var aoe_collision: CollisionShape2D = $CollisionShape2D
signal on_contact(npc: Npc)
var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aoe_collision.shape.radius = radius
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# For some reason the overlapping bodies is not ready on the first frame so we need to wait one frame.
	await get_tree().process_frame
	for body in get_overlapping_bodies():
		on_contact.emit(body)
	self.queue_free()
	pass
