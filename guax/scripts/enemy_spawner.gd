extends Area2D

var enemies_alive: Array[Npc]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn(enemy: Npc):
	enemies_alive.append(enemy)
	enemy.on_death.connect(_on_enemy_death)
	add_child(enemy)
	
func _on_enemy_death(enemy: Npc):
	enemies_alive.erase(enemy)
	# No more enemies alive
	if enemies_alive.size() <= 0:
		TurnManager.end_phase_requested.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
