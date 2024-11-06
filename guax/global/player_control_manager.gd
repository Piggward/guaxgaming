extends Node

var dragging = false
var drag_area: DragableArea2D
var cd = false

func _process(delta):
	# if dragging and want to place
	if dragging && (Input.is_action_just_pressed("left_mouse") || Input.is_action_just_released("left_mouse")) && not cd:
		if drag_area.can_release():
			drag_area.release()
			stop_dragging()
			
	# if dragging and want to cancel
	if dragging && Input.is_action_just_pressed("right_mouse") && not cd:
		drag_area.cancel()
		stop_dragging()
		
func can_drag():
	return not dragging && TurnManager.current_phase.phase == TurnPhase.Phase.SHOPPING
	
func start_dragging(d_area: DragableArea2D):
	get_tree().root.add_child(d_area)
	d_area.dragging = true
	drag_area = d_area
	self.dragging = true
	set_input_cd()
	
func stop_dragging():
	dragging = false
	drag_area = null
	set_input_cd()

func set_input_cd():
	cd = true
	await get_tree().create_timer(0.2).timeout
	cd = false
	
