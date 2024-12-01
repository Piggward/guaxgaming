class_name EnemyIdleState
extends NpcState


func  act():
	# do nothing 
	pass

func enter():
	#npc.set_agent_target(npc.global_position)
	npc.play_animation(npc.title+"/Idle")
	# Maybe there is a better way, but if velocity is not reset to zero, then the character will keep moving while in idle.
	npc.velocity = Vector2.ZERO
	TurnManager.battle_turn.turn_start.connect(func(): transition_requested.emit(self, NpcState.State.HUNTING))
	npc.on_input.connect(_on_input_event)

func exit():
	pass

func _on_input_event(event: InputEvent):
	if event.is_action_pressed("right_mouse"):
		GameManager.display_information_card.emit(npc)
		
