extends Node

var dragging = false
var drag_object: PlaceholderUnit
var cd = false

func _process(delta):
	# if dragging and want to place
	if dragging && (Input.is_action_just_pressed("left_mouse") || Input.is_action_just_released("left_mouse")) && not cd:
		if drag_object.can_release():
			drag_object.release()
			stop_dragging()
			
	# if dragging and want to cancel
	if dragging && Input.is_action_just_pressed("right_mouse") && not cd:
		drag_object.cancel()
		stop_dragging()
		
func can_drag():
	return not dragging && TurnManager.current_phase.phase == TurnPhase.Phase.SHOPPING
	
func start_dragging(ms: PlaceholderUnit):
	get_tree().root.add_child(ms)
	ms.dragging = true
	drag_object = ms
	self.dragging = true
	set_input_cd()
	
func stop_dragging():
	dragging = false
	drag_object = null
	set_input_cd()

func set_input_cd():
	cd = true
	await get_tree().create_timer(0.2).timeout
	cd = false
	
