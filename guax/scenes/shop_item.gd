extends Control

@export var soldier: TestSoldierResource
@export var soldier_scene: PackedScene

@onready var unit_name = $VBoxContainer/CoreShopItemPanel/VBoxContainer/HeaderShopItemPanel/UnitName
@onready var unit_info = $VBoxContainer/CoreShopItemPanel/VBoxContainer/UnitInfo
@onready var unit_cost = $VBoxContainer/CostPanel/UnitCost

var cd = false

# Called when the node enters the scene tree for the first time.
func _ready():
	unit_name.text = soldier.title
	#unit_info.text = "enter information here"
	unit_cost.text = str(soldier.cost)
	pass # Replace with function body.


func _on_gui_input(event):
	if event.is_action_pressed("left_mouse") && !cd && PlayerControlManager.can_drag():
		# can afford? 
		if soldier.cost > GameManager.player_gold:
			print("cant afford bro")
		
		# create placeholder
		var ss = soldier_scene.instantiate()
		if not ss is TestSoldier:
			return
		var placeholder = ss.get_placeholder()
		
		# Add placeholder to PlayerControlManager
		PlayerControlManager.start_dragging(placeholder)
		
		# Listen for placed signal to commit the transaction
		placeholder.placed.connect(commit_transaction)
		
		# Set input CD
		set_cd()
		pass
		
func commit_transaction(placeholder: PlaceholderUnit):
	GameManager.soldier_purchased.emit(placeholder.actual_soldier)
	placeholder.placed.disconnect(commit_transaction)

func set_cd():
	cd = true
	await get_tree().create_timer(0.2).timeout
	cd = false
