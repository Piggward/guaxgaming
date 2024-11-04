class_name NpcState
extends Node

enum State{
	IDLE,
	HUNTING,
	ATTACKING
}

var npc:Npc

signal transition_requested(from: NpcState, to: State)
@export var state:State

func  act():
	pass

func enter():
	pass

func exit():
	pass
