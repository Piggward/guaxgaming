class_name Shop
extends Control

@onready var container = $PanelContainer/MarginContainer/HBoxContainer
const SHOP_ITEM = preload("res://scenes/shop_item.tscn")
@export var items: Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.shop_turn.turn_start.connect(_on_shop_turn_start)
	TurnManager.shop_turn.turn_end.connect(_on_shop_turn_end)
	for item in items:
		var sitem = SHOP_ITEM.instantiate()
		sitem.npc_scene = item
		container.add_child(sitem)
		
	#var offset = self.size.x
	#position -= offset / 2
	pass # Replace with function body.

func _on_shop_turn_start():
	self.visible = true
	
func _on_shop_turn_end():
	self.visible = false
