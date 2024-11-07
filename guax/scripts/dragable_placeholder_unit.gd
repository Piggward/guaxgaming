class_name DragablePlaceholderUnit
extends PlaceholderUnit

var dragging = false
var cd = false
signal placed(placeholder: PlaceholderUnit)

# Called when the node enters the scene tree for the first time.
func _ready():
	input_event.connect(_on_input_event)
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
	return not colliding() and in_dropable_area()
	
func colliding() -> bool:
	return get_overlapping_areas().any(func(a): return not a.is_in_group("Placeable"))
	
func in_dropable_area() -> bool:
	return get_overlapping_areas().any(func(a): return a.is_in_group("Placeable"))
		
func release() -> void:
	dragging = false
	battle_position = self.global_position
	placed.emit(self)
	set_input_cd()
			
func set_input_cd():
	cd = true
	await get_tree().create_timer(0.2).timeout
	cd = false
	
func cancel():
	if battle_position == null: 
		self.queue_free()
	else:
		self.global_position = battle_position
		release()
