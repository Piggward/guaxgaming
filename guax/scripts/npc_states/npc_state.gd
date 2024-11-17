class_name NpcState
extends Node

enum State{
	IDLE,
	HUNTING,
	ATTACKING,
	DEAD,
}
var npc: Npc
var target: Npc

signal transition_requested(from: NpcState, to: State)
@export var state:State

func act():
	pass

func enter():
	pass

func exit():
	pass

func _ready(): 
	TurnManager.battle_turn.turn_end.connect(func(): target = null)
