class_name TurnPhase
extends Node

enum Phase {SHOPPING, BATTLE}
signal turn_start()
signal turn_end()

var phase: Phase

func phase_start():
	pass
	
func phase_end():
	pass
	
func phase_act():
	pass
