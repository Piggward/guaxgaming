extends Control

@export var npc_scene: PackedScene

@onready var unit_name = $VBoxContainer/CoreShopItemPanel/VBoxContainer/HeaderShopItemPanel/MarginContainer/UnitName
@onready var unit_info = $VBoxContainer/CoreShopItemPanel/VBoxContainer/UnitInfo
@onready var unit_cost = $VBoxContainer/CostPanel/UnitCost

var store_front: Ally
var base_attributes: BaseAttributes
var cd = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var npc = npc_scene.instantiate()
	if not npc is Ally:
		print_debug("ERROR: scene needs to be an ally")
		return
		
	store_front = npc
	base_attributes = npc.base_attributes
	
	set_display_text()
	pass # Replace with function body.

func _on_gui_input(event):
	if event.is_action_pressed("left_mouse") && !cd && GameManager.can_purchase(store_front.cost) && PlayerControlManager.can_drag():
		var ally: Ally = store_front.duplicate()
		get_tree().root.add_child(ally)
		ally.out_of_battle_state_machine.current_state.pick_from_shop()
		ally.activate()
		# Listen for placed signal to commit the transaction
		ally.reposition.connect(commit_transaction)

		# Set input CD
		set_cd()
		pass
		
func commit_transaction(ally: Ally):
	GameManager.ally_purchased.emit(ally)
	ally.reposition.disconnect(commit_transaction)

func set_cd():
	cd = true
	await get_tree().create_timer(0.2).timeout
	cd = false
	
func set_display_text():
	unit_name.text = base_attributes.title
	unit_info.text = "damage: " + str(base_attributes.base_attack.damage) + "\n"
	unit_info.text += "speed: " + str(base_attributes.speed) + "\n"
	unit_info.text += "range: " + str(base_attributes.base_attack.range) + "\n"
	unit_cost.text = str(store_front.cost)
