class_name UpgradeCard
extends Control

@onready var unit_name = $HeaderShopItemPanel/UnitName
@onready var upgrade_cost = $CoreShopItemPanel/VBoxContainer/UpgradeCostPanel/UpgradeCost
@onready var stats_label = $CoreShopItemPanel/VBoxContainer/UpgradeContainer/StatsLabel
@onready var upgrade_cost_panel = $CoreShopItemPanel/VBoxContainer/UpgradeCostPanel
@export var ally: Ally
const UPGRADE_ITEM = preload("res://scenes/upgrade_item.tscn")
@onready var promotion_container = $CoreShopItemPanel/VBoxContainer/PromotionContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true
	refresh_card()
	ally.promoting.connect(on_promotion)
	pass # Replace with function body.


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("left_mouse"):
		self.queue_free()
	pass
		

func _on_upgrade_cost_panel_gui_input(event):
	if event.is_action_released("left_mouse") && GameManager.can_purchase(ally.upgrade.cost):
		GameManager.transaction(ally.upgrade.cost)
		ally.basic_upgrade()
		stats_label.text = "Damage: {dmg}
	Range: {rng}
	Attackspeed: {atsp}
	Base health: {bsh}".format({"dmg": str(ally.attack.damage), "rng": str(ally.attack.range),"atsp": ally.attackspeed, "bsh": ally.maxHealth})
	pass # Replace with function body.
	
func populate_promotion_container():
	for promotion in ally.promotion_path:
		var cont = VBoxContainer.new()
		var upgrade_item = UPGRADE_ITEM.instantiate()
		upgrade_item.promotion = promotion
		upgrade_item.ally = ally
		cont.add_child(upgrade_item)
		promotion_container.add_child(cont)

func refresh_card():
	promotion_container.get_children().map(func(c): c.queue_free())
	set_display_text()
	populate_promotion_container()
	
func on_promotion(from, to):
	ally = to
	refresh_card()

func set_display_text():
	stats_label.text = "Damage: {dmg}
Range: {rng}
Attackspeed: {atsp}
Base health: {bsh}".format({"dmg": str(ally.attack.damage), "rng": str(ally.attack.range),"atsp": ally.attackspeed, "bsh": ally.maxHealth})
	upgrade_cost.text = str(ally.upgrade.cost) + " gold"
	unit_name.text = ally.title + " level: " + str(ally.upgrade_level)
