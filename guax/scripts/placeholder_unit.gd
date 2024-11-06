class_name PlaceholderUnit
extends Area2D

var battle_position = null
var actual_unit: Npc

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func deactivate():
	self.visible = false
	process_mode = PROCESS_MODE_DISABLED
	pass

func activate():
	self.visible = true
	process_mode = PROCESS_MODE_INHERIT
	pass
