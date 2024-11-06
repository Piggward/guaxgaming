class_name PlaceholderUnit
extends Area2D

var battle_position = null
var actual_unit: Npc
@export var dragable = true

signal placed(placeholder: PlaceholderUnit)

# Called when the node enters the scene tree for the first time.
func _ready():
	if dragable:
		add_dragable_area()
	pass # Replace with function body.

func add_dragable_area():
	var drag_area = DragableArea2D.new()
	get_tree().root.add_child(drag_area)
	self.reparent(drag_area)
	self.position = Vector2.ZERO
	drag_area.canceled.connect(_on_drag_cancel)
	drag_area.placed.connect(_on_placed)
	
	# Placeable zone is hardcoded here, consider adding placable_zone variable to the ally script instead.
	if actual_unit is Ally:
		drag_area.placable_zone = "Placeable"
		
	PlayerControlManager.start_dragging(drag_area)
	
func _on_drag_cancel():
	if battle_position == null:
		self.queue_free()
	else:
		self.global_position = battle_position
		
func _on_placed():
	battle_position = self.global_position
	placed.emit(self)
