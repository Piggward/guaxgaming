class_name DragableArea2D
extends Area2D

var dragging = false
var cd = false
var placable_zone: String

signal placed()
signal canceled()

# Called when the node enters the scene tree for the first time.
func _ready():
	child_entered_tree.connect(child_entered)
	pass # Replace with function body.
	
func _process(delta):
	if not dragging:
		return
	global_position = get_global_mouse_position()
		
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse") && !dragging && not cd && PlayerControlManager.can_drag():
		dragging = true
		PlayerControlManager.start_dragging(self)
		set_input_cd()
	pass # Replace with function body.
	
func can_release() -> bool:
	var not_colliding = get_children().all(func(c): return not colliding(c))
	var in_dropable_area = get_children().all(func(c): return in_dropable_area(c))
	return not_colliding and in_dropable_area
	
func colliding(area: Area2D) -> bool:
	return area.get_overlapping_areas().any(func(a): return not a.is_in_group(placable_zone))
	
func in_dropable_area(area: Area2D) -> bool:
	return area.get_overlapping_areas().any(func(a): return a.is_in_group(placable_zone))
		
func release() -> void:
	dragging = false
	placed.emit()
	set_input_cd()
			
func set_input_cd():
	cd = true
	await get_tree().create_timer(0.2).timeout
	cd = false
	
func cancel():
	canceled.emit()
	
func child_exited():
	if not get_children().any(func(c): return c is not CollisionShape2D):
		self.queue_free()

func child_entered(child):
	child.tree_exited.connect(child_exited)
