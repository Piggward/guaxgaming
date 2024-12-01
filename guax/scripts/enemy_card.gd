class_name EnemyCard
extends Control

@onready var unit_name = $VBoxContainer/HeaderShopItemPanel/UnitName
@onready var stats_label = $VBoxContainer/CoreShopItemPanel/VBoxContainer/UpgradeContainer/StatsLabel
@export var enemy: Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true
	refresh_card()
	pass # Replace with function body.


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("left_mouse"):
		self.queue_free()
	pass
		
func refresh_card():
	set_display_text()

func set_display_text():
	stats_label.text = "Damage: {dmg}
Range: {rng}
Attackspeed: {atsp}
Base health: {bsh}".format({"dmg": str(enemy.starting_attack.damage), "rng": str(enemy.starting_attack.range),"atsp": enemy.attackspeed, "bsh": enemy.maxHealth})
	unit_name.text = enemy.title
