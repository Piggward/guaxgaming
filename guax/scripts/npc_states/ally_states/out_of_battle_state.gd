class_name OutOfBattleState
extends Node

enum State{
	NONE,
	PLACED,
	DRAGGING,
	SHOPDISPLAY
}

var ally: Ally

signal transition_requested(from: OutOfBattleState, to: State)
@export var state:State

func enter():
	pass

func exit():
	pass
	
