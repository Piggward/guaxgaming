extends ProgressBar
const DAMAGE_LABEL = preload("res://scenes/damage_label.tscn")
@onready var parent = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	if not parent.is_node_ready():
		await parent.ready
	var npc = parent
	npc.receive_damage.connect(_on_damage_taken)
	npc.health_updated.connect(_on_health_updated)
	self.max_value = npc.maxHealth
	self.value = npc.currentHealth
	pass # Replace with function body.

func _on_damage_taken(amount: int):
	# Create damage label
	var dlabel = DAMAGE_LABEL.instantiate()
	dlabel.global_position = self.global_position
	dlabel.text = str(amount)
	get_tree().root.add_child(dlabel)
	
	# Offset the position of the label so it fits better with the progress bar
	dlabel.position.x += self.size.x / 2
	dlabel.position.y -= self.size.y
	dlabel.position.x -= dlabel.size.x / 2
	pass
	
func _on_health_updated(new_health: int):
	self.value = clamp(new_health, 0, max_value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
