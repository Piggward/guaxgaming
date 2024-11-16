class_name DragingState
extends OutOfBattleState

var cd = true
var placable_areas: Array[Area2D]

func enter():
	cd = true
	PlayerControlManager.dragging = true
	for area in get_tree().get_nodes_in_group("Placeable"):
		area.connect("body_entered", on_body_entered_placeable_area.bind(area))
		area.connect("body_exited", on_body_exited_placeable_area.bind(area))
	set_process(true)
	await get_tree().create_timer(0.2).timeout
	cd = false
	pass

func on_body_entered_placeable_area(body, area):
	if body == ally:
		placable_areas.append(area)
		
func on_body_exited_placeable_area(body, area):
	if body == ally:
		placable_areas.erase(area)
		

func exit():
	PlayerControlManager.dragging = false
	for area in placable_areas:
		area.disconnect("body_entered", on_body_entered_placeable_area.bind(area))
		area.disconnect("body_exited", on_body_exited_placeable_area.bind(area))
	set_process(false)
	pass

func _process(delta):
	ally.global_position = ally.get_global_mouse_position()
	
	if Input.is_action_just_released("left_mouse") && not cd && can_release():
		ally.reposition.emit(ally)
		transition_requested.emit(self, OutOfBattleState.State.PLACED)
		
	if Input.is_action_just_pressed("right_mouse") && not cd:
		cancel()
		
func can_release() -> bool:
	return in_dropable_area()
	
#func colliding() -> bool:
	#return ally.get_overlapping_areas().any(func(a): return not a.is_in_group("Placeable"))
	
func in_dropable_area() -> bool:
	return placable_areas.size() > 0
	
func cancel():
	if ally.battle_start_location == null: 
		ally.queue_free()
	else:
		ally.global_position = ally.battle_start_location
		transition_requested.emit(self, OutOfBattleState.State.PLACED)
