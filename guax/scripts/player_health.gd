extends PanelContainer

@onready var health_bar = $HealthBar
@onready var health_label = $HealthBar/HealthLabel
@onready var level = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player_health_updated.connect(on_health_updated)
	if !level.is_node_ready():
		await level.is_node_ready()
		
	health_bar.max_value = level.player_starting_health
	health_bar.value = level.player_starting_health
	health_label.text = str(level.player_starting_health) + "/" + str(level.player_starting_health)
	pass # Replace with function body.


func on_health_updated(new_health: int):
	health_bar.value = new_health
	health_label.text = str(new_health) + "/" + str(GameManager.player_max_health)
