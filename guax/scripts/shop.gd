class_name Shop
extends Control

const SHOP_ITEM_CONTAINER = preload("res://scenes/shop/shop_item_container.tscn")
const SHOP_ITEM = preload("res://scenes/shop_item.tscn")
@onready var shop_rows = $PanelContainer/VBoxContainer/MarginContainer/ScrollContainer/ShopRows

var container: HBoxContainer

@export var items: Array[PackedScene]
# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.shop_turn.turn_start.connect(_on_shop_turn_start)
	TurnManager.shop_turn.turn_end.connect(_on_shop_turn_end)
	container = SHOP_ITEM_CONTAINER.instantiate()
	for item in items:
		if container.get_child_count() == 2:
			add_container_to_scene()
			
		var sitem = SHOP_ITEM.instantiate()
		sitem.npc_scene = item
		
		container.add_child(sitem)
		
	add_container_to_scene()
	pass # Replace with function body.

	
		
func add_container_to_scene():
	shop_rows.add_child(container.duplicate())
	container = SHOP_ITEM_CONTAINER.instantiate()
	pass

func _on_shop_turn_start():
	self.visible = true
	
func _on_shop_turn_end():
	self.visible = false
