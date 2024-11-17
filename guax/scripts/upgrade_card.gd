class_name UpgradeCard
extends Control

@onready var unit_name = $HeaderShopItemPanel/UnitName
@onready var upgrade_cost = $CoreShopItemPanel/VBoxContainer/UpgradeCostPanel/UpgradeCost
@onready var stats_label = $CoreShopItemPanel/VBoxContainer/UpgradeContainer/StatsLabel
@onready var upgrade_cost_panel = $CoreShopItemPanel/VBoxContainer/UpgradeCostPanel
@export var ally: Ally
@onready var class_upgrade_container = $CoreShopItemPanel/VBoxContainer/ClassUpgradeContainer
const UPGRADE_ITEM = preload("res://scenes/upgrade_item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true
	stats_label.text = "Damage: {dmg}
Range: {rng}
Attackspeed: {atsp}
Base health: {bsh}".format({"dmg": str(ally.attack.damage), "rng": str(ally.attack.range),"atsp": ally.attackspeed, "bsh": ally.maxHealth})
	upgrade_cost.text = str(ally.ally_class.upgrade.cost) + " gold"
	unit_name.text = ally.title + " level: " + str(ally.upgrade_level)
	for upgrade in ally.ally_class.class_upgrades:
		var cont = VBoxContainer.new()
		var upgrade_item = UPGRADE_ITEM.instantiate()
		upgrade_item.upgrade = upgrade
		upgrade_item.ally = ally
		cont.add_child(upgrade_item)
		class_upgrade_container.add_child(cont)
	pass # Replace with function body.


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("left_mouse"):
		self.queue_free()
	pass
		

func _on_upgrade_cost_panel_gui_input(event):
	if event.is_action_released("left_mouse"):
		ally.basic_upgrade()
		stats_label.text = "Damage: {dmg}
	Range: {rng}
	Attackspeed: {atsp}
	Base health: {bsh}".format({"dmg": str(ally.attack.damage), "rng": str(ally.attack.range),"atsp": ally.attackspeed, "bsh": ally.maxHealth})
	pass # Replace with function body.
