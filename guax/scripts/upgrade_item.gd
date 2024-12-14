class_name UpgradeItem
extends Control

@export var promotion: Promotion
@export var ally: Ally
@onready var upgrade_item_title = $UpgradeItemVbox/UpgradeItemPanel/UpgradeItemVBoxContainer/UpgradeItemHeaderPanel/UpgradeItemTitle
@onready var upgrade_item_info = $UpgradeItemVbox/UpgradeItemPanel/UpgradeItemVBoxContainer/UpgradeItemInfo
@onready var upgrade_item_cost = $UpgradeItemVbox/UpgradeItemCostPanel/UpgradeItemCost


# Called when the node enters the scene tree for the first time.
func _ready():
	var upg = promotion.promotion_scene.instantiate()
	set_display_text(upg)
	pass # Replace with function body.

func set_display_text(upg: Ally):
	upgrade_item_title.text = upg.base_attributes.title
	upgrade_item_info.text = "damage: " + str(upg.base_attributes.base_attack.damage) + "\n"
	upgrade_item_info.text += "speed: " + str(upg.base_attributes.speed) + "\n"
	upgrade_item_info.text += "range: " + str(upg.base_attributes.base_attack.range) + "\n"
	upgrade_item_info.text += "health: " + str(upg.base_attributes.maxHealth) + "\n"
	upgrade_item_cost.text = str(promotion.cost) + " " + promotion.cost_type


func _on_upgrade_item_cost_panel_gui_input(event):
	if event.is_action_released("left_mouse"):
		ally.promote(promotion)
	pass # Replace with function body.
