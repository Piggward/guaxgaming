class_name UpgradeItem
extends Control

@export var upgrade: Class
@export var ally: Ally
@onready var upgrade_item_title = $UpgradeItemVbox/UpgradeItemPanel/UpgradeItemVBoxContainer/UpgradeItemHeaderPanel/UpgradeItemTitle
@onready var upgrade_item_info = $UpgradeItemVbox/UpgradeItemPanel/UpgradeItemVBoxContainer/UpgradeItemInfo
@onready var upgrade_item_cost = $UpgradeItemVbox/UpgradeItemCostPanel/UpgradeItemCost


# Called when the node enters the scene tree for the first time.
func _ready():
	var upg = upgrade.get_class_upgrade_instance()
	set_display_text(upg)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_display_text(store_front: Ally):
	upgrade_item_title.text = store_front.title
	upgrade_item_info.text = "damage: " + str(store_front.attack.damage) + "\n"
	upgrade_item_info.text += "speed: " + str(store_front.speed) + "\n"
	upgrade_item_info.text += "range: " + str(store_front.attack.range) + "\n"
	upgrade_item_cost.text = str(upgrade.cost) + " RUBY"


func _on_upgrade_item_cost_panel_gui_input(event):
	if event.is_action_released("left_mouse"):
		ally.class_upgrade(upgrade)
	pass # Replace with function body.
