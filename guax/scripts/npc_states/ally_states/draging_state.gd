class_name DragingState
extends OutOfBattleState

var cd = true
var placable_area: Area2D
var collision_area: Area2D

func _ready():
	set_process(false)

func enter():
	add_temp_collision_to_ally()
	ally.collision_shape.disabled = true
	cd = true
	PlayerControlManager.dragging = true
	placable_area = get_tree().get_nodes_in_group("Placeable")[0]
	set_process(true)
	await get_tree().create_timer(0.2).timeout
	cd = false
	pass
		

func exit():
	collision_area.queue_free()
	ally.collision_shape.disabled = false
	PlayerControlManager.dragging = false
	set_process(false)
	pass

func _process(delta):
	ally.global_position = ally.get_global_mouse_position()
	
	if Input.is_action_just_released("left_mouse") && not cd && can_release():
		ally.reposition.emit(ally)
		ally.reparent(placable_area)
		transition_requested.emit(self, OutOfBattleState.State.PLACED)
		
	if Input.is_action_just_pressed("right_mouse") && not cd:
		cancel()
		
func can_release() -> bool:
	return in_dropable_area() && !collision_area.get_overlapping_bodies().any(func(b): return b is Npc)
	
#func colliding() -> bool:
	#return ally.get_overlapping_areas().any(func(a): return not a.is_in_group("Placeable"))
	
func in_dropable_area() -> bool:
	return placable_area.get_overlapping_areas().any(func(a): return a == collision_area)
	
func cancel():
	if ally.battle_start_location == Vector2.ZERO: 
		PlayerControlManager.dragging = false
		ally.queue_free()
	else:
		ally.global_position = ally.battle_start_location
		transition_requested.emit(self, OutOfBattleState.State.PLACED)
		
func add_temp_collision_to_ally():
	collision_area = Area2D.new()
	var collision = ally.collision_shape.duplicate()
	collision_area.add_child(collision)
	ally.add_child(collision_area)
