class_name Projectile
extends RigidBody2D

@export var target: Npc
@export var travel_speed: float

signal target_reached()
# Called when the node enters the scene tree for the first time.
func _ready():
	# Limit lifetime of a projectile
	await get_tree().create_timer(5).timeout
	self.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if target is reached (with some margin)
	if (self.global_position - target.global_position).length() < 5:
		target_reached.emit(target)
		#here we can play some kind of explosion effect or something
		self.queue_free()
		
	else:
		look_at(target.global_position)
		global_position += Vector2(0, -travel_speed).rotated(rotation + deg_to_rad(90))
	pass
