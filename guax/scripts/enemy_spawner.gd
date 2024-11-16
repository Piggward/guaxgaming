class_name EnemySpawner
extends Area2D

var enemies_alive: Array[Enemy]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_enemy(enemy: Enemy):
	var spawn = enemy.duplicate()
	enemies_alive.append(spawn)
	spawn.on_death.connect(_on_enemy_death)
	self.add_child(spawn)
	
func _on_enemy_death(enemy: Npc):
	enemies_alive.erase(enemy)
	# No more enemies alive
	if enemies_alive.size() <= 0 && TurnManager.current_phase.phase == TurnPhase.Phase.BATTLE:
		TurnManager.end_phase_requested.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
