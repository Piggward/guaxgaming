extends Area2D

var enemies_alive: Array[Enemy]
const PlaceholderUnit = preload("res://scripts/placeholder_unit.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.battle_turn.turn_start.connect(_on_battle_start)
	pass # Replace with function body.

func spawn_enemy(enemy: Enemy):
	enemies_alive.append(enemy)
	enemy.on_death.connect(_on_enemy_death)
	
	# Add enemy to EnemySpawn, but deactivate it and add a placeholder instead
	enemy.reparent(self, false)
	var ph = PlaceholderUnit.new()
	enemy.set_placeholder(ph)
	ph.add_child(enemy.root_sprites.duplicate())
	ph.position = enemy.position
	self.add_child(ph)
	enemy.deactivate()
	
func _on_battle_start():
	# When battle start, replace placeholder with the enemy
	for child in get_children():
		if child is PlaceholderUnit:
			child.actual_unit.activate()
			child.queue_free()
	
func _on_enemy_death(enemy: Npc):
	enemies_alive.erase(enemy)
	# No more enemies alive
	if enemies_alive.size() <= 0:
		TurnManager.end_phase_requested.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
