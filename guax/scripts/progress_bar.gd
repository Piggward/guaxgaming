extends ProgressBar
const DAMAGE_LABEL = preload("res://scenes/damage_label.tscn")
@onready var parent = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	if not parent.is_node_ready():
		await parent.ready
	var npc = parent
	npc.receive_damage.connect(on_damage_taken)
	self.max_value = npc.maxHealth
	self.value = npc.currentHealth
	pass # Replace with function body.

func on_damage_taken(amount: int):
	self.value = clamp(self.value - amount, 0, max_value)
	var dlabel = DAMAGE_LABEL.instantiate()
	self.add_child(dlabel)
	dlabel.text = str(amount)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
